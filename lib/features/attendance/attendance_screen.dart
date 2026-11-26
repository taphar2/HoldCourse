import 'package:drift/drift.dart' hide Column;
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:hold_course/core/db/database.dart';
import 'package:hold_course/features/attendance/attendance_dialog.dart';
import 'package:hold_course/features/timetable/time_labels.dart';
import 'package:holdcourse_domain/holdcourse_domain.dart';
import 'package:material_ui/material_ui.dart';
import 'package:rxdart/rxdart.dart';

/// Self-assessment attendance: derived past classes, marking and course totals.
class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({
    super.key,
    required this.database,
    required this.onOpenSettings,
    required this.onOpenTimetable,
    this.now,
  });

  final AppDatabase database;
  final VoidCallback onOpenSettings;
  final VoidCallback onOpenTimetable;
  final DateTime Function()? now;

  DateTime _now() => now?.call() ?? DateTime.now();

  Stream<_AttendanceData> _watch() {
    return Rx.combineLatest5(
      database.select(database.courses).watch(),
      database.select(database.weeklySlots).watch(),
      database.select(database.slotChanges).watch(),
      database.select(database.attendanceMarks).watch(),
      database.select(database.appSettings).watch(),
      (
        List<Course> courses,
        List<WeeklySlot> slots,
        List<SlotChange> changes,
        List<AttendanceMark> marks,
        List<AppSetting> settings,
      ) {
        return _AttendanceData(
          courses: courses,
          slots: slots,
          changes: changes,
          marks: marks,
          settings: settings,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<_AttendanceData>(
      stream: _watch(),
      builder: (BuildContext context, AsyncSnapshot<_AttendanceData> snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final _AttendanceData data = snapshot.data!;
        if (data.settings.isEmpty) {
          return _messageScreen(
            context: context,
            icon: LucideIcons.settings,
            title: 'Set your semester dates',
            message:
                'Attendance needs to know when this semester starts and ends '
                'before it can list past classes.',
            buttonLabel: 'Open settings',
            onPressed: onOpenSettings,
          );
        }
        if (data.courses.isEmpty) {
          return _messageScreen(
            context: context,
            icon: LucideIcons.calendar_days,
            title: 'No courses yet',
            message:
                'Add a course and its weekly classes to start tracking '
                'attendance.',
            buttonLabel: 'Open timetable',
            onPressed: onOpenTimetable,
          );
        }
        return _buildAttendance(context, data);
      },
    );
  }

  Widget _messageScreen({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String message,
    required String buttonLabel,
    required VoidCallback onPressed,
  }) {
    return Scaffold(
      appBar: AppBar(title: const Text('Attendance')),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 48,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  message,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                FilledButton.icon(
                  onPressed: onPressed,
                  icon: const Icon(LucideIcons.arrow_right),
                  label: Text(buttonLabel),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAttendance(BuildContext context, _AttendanceData data) {
    final int threshold = data.settings.first.attendanceThreshold;
    final List<_ClassRow> rows = _rows(data);
    final List<_CourseSummary> summaries = _summaries(data, rows);
    final int unmarked = rows
        .where((_ClassRow row) => row.status == AttendanceStatus.unmarked)
        .length;

    return Scaffold(
      appBar: AppBar(title: const Text('Attendance')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          if (unmarked > 0)
            Card(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(
                      LucideIcons.clock_3,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '$unmarked '
                        '${unmarked == 1 ? 'class needs' : 'classes need'} '
                        'marking',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimaryContainer,
                        ),
                      ),
                    ),
                    FilledButton(
                      onPressed: () {
                        final _ClassRow first = rows.firstWhere(
                          (_ClassRow row) =>
                              row.status == AttendanceStatus.unmarked,
                        );
                        _mark(context, first);
                      },
                      child: const Text('Mark now'),
                    ),
                  ],
                ),
              ),
            ),
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListTile(
                  title: const Text('By course'),
                  subtitle: Text('Target $threshold% · ranked by attendance'),
                ),
                for (int index = 0; index < summaries.length; index++)
                  _summaryTile(context, summaries[index], index + 1, threshold),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 20, 4, 8),
            child: Text(
              'Classes',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          if (rows.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'No classes have finished yet.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          for (final _ClassRow row in rows) _classTile(context, row),
        ],
      ),
    );
  }

  Widget _summaryTile(
    BuildContext context,
    _CourseSummary item,
    int rank,
    int threshold,
  ) {
    final AttendanceSummary summary = item.summary;
    final double? percentage = summary.percentage;
    return ListTile(
      leading: CircleAvatar(child: Text('$rank')),
      title: Text('${item.course.code} · ${item.course.title}'),
      subtitle: Text(
        '${summary.present} present · ${summary.absent} absent · '
        '${summary.unmarked} unmarked · ${_outlook(summary, threshold)}',
      ),
      trailing: Text(
        percentage == null ? '—' : '${percentage.round()}%',
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }

  Widget _classTile(BuildContext context, _ClassRow row) {
    final ThemeData theme = Theme.of(context);
    final Color color = _statusColor(theme, row.status);
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.15),
          child: Icon(_statusIcon(row.status), color: color),
        ),
        title: Text('${row.course.code} · ${row.course.title}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              _whenLabel(context, row.session) +
                  ((row.mark?.note ?? '').isEmpty
                      ? ''
                      : ' · ${row.mark!.note}'),
            ),
            const SizedBox(height: 6),
            Text(
              _statusLabel(row.status),
              style: theme.textTheme.labelMedium?.copyWith(color: color),
            ),
          ],
        ),
        trailing: IconButton(
          tooltip: 'Mark attendance',
          icon: Icon(row.mark == null ? LucideIcons.plus : LucideIcons.pencil),
          onPressed: () => _mark(context, row),
        ),
        onTap: () => _mark(context, row),
      ),
    );
  }

  Future<void> _mark(BuildContext context, _ClassRow row) async {
    final AttendanceFormResult? result = await showAttendanceDialog(
      context,
      courseLabel: '${row.course.code} · ${row.course.title}',
      when: _whenLabel(context, row.session),
      existing: row.mark,
    );
    if (result == null) {
      return;
    }
    await database.transaction(() async {
      await (database.delete(database.attendanceMarks)..where(
            (mark) =>
                mark.courseId.equals(row.session.courseId) &
                mark.date.equals(row.session.date) &
                mark.startMinute.equals(row.session.startMinute),
          ))
          .go();
      await database
          .into(database.attendanceMarks)
          .insert(
            AttendanceMarksCompanion.insert(
              courseId: row.session.courseId,
              date: row.session.date,
              startMinute: row.session.startMinute,
              status: result.status,
              note: Value(result.note.isEmpty ? null : result.note),
              markedAt: _now(),
            ),
          );
    });
  }

  List<_ClassRow> _rows(_AttendanceData data) {
    final AppSetting settings = data.settings.first;
    final Map<String, Course> coursesById = {
      for (final Course course in data.courses) course.id: course,
    };
    final Map<String, AttendanceMark> marksByKey = {
      for (final AttendanceMark mark in data.marks)
        _markKey(mark.courseId, mark.date, mark.startMinute): mark,
    };
    final List<ClassSession> sessions = deriveSessions(
      rules: data.slots
          .map(
            (WeeklySlot slot) => SessionRule(
              id: slot.id,
              courseId: slot.courseId,
              weekday: slot.weekday,
              startMinute: slot.startMinute,
              endMinute: slot.endMinute,
            ),
          )
          .toList(),
      changes: data.changes
          .map(
            (SlotChange change) => SessionChange(
              courseId: change.courseId,
              date: change.date,
              kind: change.kind,
              ruleId: change.slotId,
              startMinute: change.startMinute,
              endMinute: change.endMinute,
            ),
          )
          .toList(),
      semesterStart: settings.semesterStart,
      semesterEnd: settings.semesterEnd,
      now: _now(),
    );

    return sessions
        .where(
          (ClassSession session) => coursesById.containsKey(session.courseId),
        )
        .map(
          (ClassSession session) => _ClassRow(
            session: session,
            course: coursesById[session.courseId]!,
            mark: marksByKey[session.key],
          ),
        )
        .toList()
        .reversed
        .toList();
  }

  List<_CourseSummary> _summaries(_AttendanceData data, List<_ClassRow> rows) {
    final Map<String, List<AttendanceStatus>> byCourse = {
      for (final Course course in data.courses) course.id: <AttendanceStatus>[],
    };
    for (final _ClassRow row in rows) {
      byCourse
          .putIfAbsent(row.session.courseId, () => <AttendanceStatus>[])
          .add(row.status);
    }
    final List<_CourseSummary> summaries = <_CourseSummary>[
      for (final Course course in data.courses)
        _CourseSummary(
          course: course,
          summary: AttendanceSummary.fromStatuses(
            byCourse[course.id] ?? const [],
          ),
        ),
    ];
    summaries.sort((_CourseSummary a, _CourseSummary b) {
      final double left = a.summary.percentage ?? -1;
      final double right = b.summary.percentage ?? -1;
      final int byPercentage = right.compareTo(left);
      return byPercentage != 0
          ? byPercentage
          : a.course.code.compareTo(b.course.code);
    });
    return summaries;
  }

  String _whenLabel(BuildContext context, ClassSession session) {
    return '${_dateLabel(context, session.date)} · '
        '${formatMinutes(context, session.startMinute)} – '
        '${formatMinutes(context, session.endMinute)}';
  }

  String _dateLabel(BuildContext context, DateTime date) {
    final DateTime today = _now();
    if (date.year == today.year &&
        date.month == today.month &&
        date.day == today.day) {
      return 'Today';
    }
    return MaterialLocalizations.of(context).formatCompactDate(date);
  }

  String _markKey(String courseId, DateTime date, int startMinute) {
    return '$courseId/${date.year}-${date.month}-${date.day}/$startMinute';
  }

  String _outlook(AttendanceSummary summary, int threshold) {
    final int? missed = summary.classesCanBeMissed(threshold);
    if (missed != null && missed > 0) {
      return '$missed can still be missed';
    }
    final int? needed = summary.classesNeededToRecover(threshold);
    if (needed != null && needed > 0) {
      return '$needed present needed to recover';
    }
    return 'On track';
  }

  String _statusLabel(AttendanceStatus status) {
    return switch (status) {
      AttendanceStatus.present => 'Present',
      AttendanceStatus.absent => 'Absent',
      AttendanceStatus.unmarked => 'Unmarked · counted as absent',
    };
  }

  IconData _statusIcon(AttendanceStatus status) {
    return switch (status) {
      AttendanceStatus.present => LucideIcons.square_check,
      AttendanceStatus.absent => LucideIcons.circle_x,
      AttendanceStatus.unmarked => LucideIcons.clock_3,
    };
  }

  Color _statusColor(ThemeData theme, AttendanceStatus status) {
    return switch (status) {
      AttendanceStatus.present => theme.colorScheme.primary,
      AttendanceStatus.absent => theme.colorScheme.error,
      AttendanceStatus.unmarked => theme.colorScheme.outline,
    };
  }
}

class _AttendanceData {
  const _AttendanceData({
    required this.courses,
    required this.slots,
    required this.changes,
    required this.marks,
    required this.settings,
  });

  final List<Course> courses;
  final List<WeeklySlot> slots;
  final List<SlotChange> changes;
  final List<AttendanceMark> marks;
  final List<AppSetting> settings;
}

class _ClassRow {
  const _ClassRow({
    required this.session,
    required this.course,
    required this.mark,
  });

  final ClassSession session;
  final Course course;
  final AttendanceMark? mark;

  AttendanceStatus get status => mark?.status ?? AttendanceStatus.unmarked;
}

class _CourseSummary {
  const _CourseSummary({required this.course, required this.summary});

  final Course course;
  final AttendanceSummary summary;
}
