import 'package:drift/drift.dart' show Value;
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:hold_course/core/db/database.dart';
import 'package:hold_course/features/timetable/course_dialog.dart';
import 'package:hold_course/features/timetable/slot_change_dialog.dart';
import 'package:hold_course/features/timetable/slot_dialog.dart';
import 'package:hold_course/features/timetable/time_labels.dart';
import 'package:holdcourse_domain/holdcourse_domain.dart';
import 'package:material_ui/material_ui.dart';
import 'package:uuid/uuid.dart';

/// The weekly timetable. It starts empty: nothing is ever seeded.
class TimetableScreen extends StatefulWidget {
  const TimetableScreen({super.key, required this.database, this.now});

  final AppDatabase database;

  /// Injectable clock for tests. Production uses the device clock.
  final DateTime Function()? now;

  @override
  State<TimetableScreen> createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  DateTime _now() => widget.now?.call() ?? DateTime.now();

  DateTime _nextDate(int weekday, [int? endMinute]) {
    final DateTime now = _now();
    final int daysAhead = (weekday - now.weekday + 7) % 7;
    DateTime date = DateTime(
      now.year,
      now.month,
      now.day,
    ).add(Duration(days: daysAhead));
    if (endMinute != null &&
        daysAhead == 0 &&
        endMinute <= now.hour * 60 + now.minute) {
      date = date.add(const Duration(days: 7));
    }
    return date;
  }

  Future<void> _addCourse(BuildContext context) async {
    final CourseFormResult? details = await showCourseDialog(context);
    if (details == null || !mounted) {
      return;
    }
    await widget.database
        .into(widget.database.courses)
        .insert(
          CoursesCompanion.insert(
            id: Uuid().v4(),
            code: details.code,
            title: details.title,
            lecturer: Value(details.lecturer.isEmpty ? null : details.lecturer),
            createdAt: _now(),
          ),
        );
  }

  Future<void> _editCourse(BuildContext context, Course course) async {
    final CourseFormResult? details = await showCourseDialog(
      context,
      initial: CourseFormResult(
        code: course.code,
        title: course.title,
        lecturer: course.lecturer ?? '',
      ),
    );
    if (details == null || !mounted) {
      return;
    }
    await (widget.database.update(
      widget.database.courses,
    )..where((row) => row.id.equals(course.id))).write(
      CoursesCompanion(
        code: Value(details.code),
        title: Value(details.title),
        lecturer: Value(details.lecturer.isEmpty ? null : details.lecturer),
      ),
    );
  }

  Future<void> _toggleArchived(BuildContext context, Course course) async {
    final bool archive = course.archivedAt == null;
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(archive ? 'Archive course?' : 'Restore course?'),
          content: Text(
            archive
                ? 'Its classes stay on the timetable, but it will not be '
                      'offered when adding a new class.'
                : 'The course will be available for new classes again.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(archive ? 'Archive' : 'Restore'),
            ),
          ],
        );
      },
    );
    if (confirmed != true) {
      return;
    }
    await (widget.database.update(widget.database.courses)
          ..where((row) => row.id.equals(course.id)))
        .write(CoursesCompanion(archivedAt: Value(archive ? _now() : null)));
  }

  List<Course> _selectableCourses(List<Course> courses, [String? includeId]) {
    return courses
        .where(
          (Course course) =>
              course.archivedAt == null || course.id == includeId,
        )
        .toList();
  }

  Future<void> _addSlot(BuildContext context, List<Course> courses) async {
    final SlotFormResult? details = await showSlotDialog(
      context,
      _selectableCourses(courses),
    );
    if (details == null || !mounted) {
      return;
    }
    await widget.database
        .into(widget.database.weeklySlots)
        .insert(
          WeeklySlotsCompanion.insert(
            id: Uuid().v4(),
            courseId: details.courseId,
            weekday: details.weekday,
            startMinute: details.startMinute,
            endMinute: details.endMinute,
            room: Value(details.room.isEmpty ? null : details.room),
          ),
        );
  }

  Future<void> _editSlot(
    BuildContext context,
    List<Course> courses,
    WeeklySlot slot,
  ) async {
    final SlotFormResult? details = await showSlotDialog(
      context,
      _selectableCourses(courses, slot.courseId),
      initial: SlotFormResult(
        courseId: slot.courseId,
        weekday: slot.weekday,
        startMinute: slot.startMinute,
        endMinute: slot.endMinute,
        room: slot.room ?? '',
      ),
    );
    if (details == null || !mounted) {
      return;
    }
    await (widget.database.update(
      widget.database.weeklySlots,
    )..where((row) => row.id.equals(slot.id))).write(
      WeeklySlotsCompanion(
        courseId: Value(details.courseId),
        weekday: Value(details.weekday),
        startMinute: Value(details.startMinute),
        endMinute: Value(details.endMinute),
        room: Value(details.room.isEmpty ? null : details.room),
      ),
    );
  }

  Future<void> _deleteSlot(BuildContext context, WeeklySlot slot) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete this class?'),
          content: const Text(
            'Attendance already recorded for this class '
            'will stay in your history.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
    if (confirmed == true) {
      await widget.database.delete(widget.database.weeklySlots).delete(slot);
    }
  }

  Future<void> _changeSlot(
    BuildContext context,
    List<Course> courses,
    WeeklySlot slot,
  ) async {
    final SlotChangeFormResult? result = await showSlotChangeDialog(
      context,
      courses: _selectableCourses(courses, slot.courseId),
      courseId: slot.courseId,
      kinds: const [SlotChangeKind.cancelled, SlotChangeKind.moved],
      initialDate: _nextDate(slot.weekday, slot.endMinute),
      initialStartMinute: slot.startMinute,
      initialEndMinute: slot.endMinute,
    );
    if (result == null || !mounted) {
      return;
    }
    await widget.database
        .into(widget.database.slotChanges)
        .insert(
          SlotChangesCompanion.insert(
            id: Uuid().v4(),
            courseId: result.courseId,
            slotId: Value(slot.id),
            date: result.date,
            kind: result.kind,
            startMinute: Value(result.startMinute),
            endMinute: Value(result.endMinute),
          ),
        );
  }

  Future<void> _addMakeUp(BuildContext context, List<Course> courses) async {
    final List<Course> active = _selectableCourses(courses);
    if (active.isEmpty) {
      return;
    }
    final SlotChangeFormResult? result = await showSlotChangeDialog(
      context,
      courses: active,
      courseId: null,
      kinds: const [SlotChangeKind.added],
      initialDate: _nextDate(_now().weekday),
      initialStartMinute: 9 * 60,
      initialEndMinute: 10 * 60,
    );
    if (result == null || !mounted) {
      return;
    }
    await widget.database
        .into(widget.database.slotChanges)
        .insert(
          SlotChangesCompanion.insert(
            id: Uuid().v4(),
            courseId: result.courseId,
            slotId: const Value<String?>(null),
            date: result.date,
            kind: result.kind,
            startMinute: Value(result.startMinute),
            endMinute: Value(result.endMinute),
          ),
        );
  }

  Future<void> _deleteChange(BuildContext context, SlotChange change) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Remove this change?'),
          content: const Text(
            'The weekly timetable and past attendance stay the same.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Remove'),
            ),
          ],
        );
      },
    );
    if (confirmed == true) {
      await widget.database.delete(widget.database.slotChanges).delete(change);
    }
  }

  String _changeLabel(SlotChangeKind kind) {
    return switch (kind) {
      SlotChangeKind.cancelled => 'Cancelled',
      SlotChangeKind.moved => 'Moved',
      SlotChangeKind.added => 'Make-up',
    };
  }

  Future<void> _showCourses(BuildContext context, List<Course> courses) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                  child: Text(
                    'Courses',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                for (final Course course in courses)
                  ListTile(
                    title: Text('${course.code} · ${course.title}'),
                    subtitle: Text(
                      course.archivedAt == null ? 'Active' : 'Archived',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          tooltip: 'Edit course',
                          icon: const Icon(LucideIcons.pencil),
                          onPressed: () => _editCourse(context, course),
                        ),
                        IconButton(
                          tooltip: course.archivedAt == null
                              ? 'Archive course'
                              : 'Restore course',
                          icon: Icon(
                            course.archivedAt == null
                                ? LucideIcons.archive
                                : LucideIcons.archive_arrow_up,
                          ),
                          onPressed: () => _toggleArchived(context, course),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Course>>(
      stream: widget.database.select(widget.database.courses).watch(),
      builder: (BuildContext context, AsyncSnapshot<List<Course>> snapshot) {
        final List<Course> courses = snapshot.data ?? const [];
        return Scaffold(
          appBar: AppBar(
            title: const Text('HoldCourse'),
            actions: [
              IconButton(
                tooltip: 'Add make-up class',
                icon: const Icon(LucideIcons.calendar_plus),
                onPressed: () => _addMakeUp(context, courses),
              ),
              IconButton(
                tooltip: 'Courses',
                icon: const Icon(LucideIcons.ellipsis),
                onPressed: () => _showCourses(context, courses),
              ),
              IconButton(
                tooltip: 'Add course',
                icon: const Icon(LucideIcons.plus),
                onPressed: () => _addCourse(context),
              ),
            ],
          ),
          body: _buildBody(context, snapshot, courses),
          floatingActionButton: courses.isEmpty
              ? null
              : FloatingActionButton.extended(
                  onPressed: () => _addSlot(context, courses),
                  icon: const Icon(LucideIcons.plus),
                  label: const Text('Add class'),
                ),
        );
      },
    );
  }

  Widget _buildBody(
    BuildContext context,
    AsyncSnapshot<List<Course>> snapshot,
    List<Course> courses,
  ) {
    if (!snapshot.hasData) {
      return const Center(child: CircularProgressIndicator());
    }
    if (courses.isEmpty) {
      return _EmptyState(
        title: 'No timetable yet',
        message: 'Add a course to start building your week.',
        buttonLabel: 'Add course',
        onPressed: () => _addCourse(context),
      );
    }

    return StreamBuilder<List<WeeklySlot>>(
      stream: widget.database.select(widget.database.weeklySlots).watch(),
      builder: (BuildContext context, AsyncSnapshot<List<WeeklySlot>> slots) {
        if (!slots.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        if (slots.data!.isEmpty) {
          return _EmptyState(
            title: 'No classes yet',
            message: 'Add the weekly classes for your courses.',
            buttonLabel: 'Add class',
            onPressed: () => _addSlot(context, courses),
          );
        }
        return StreamBuilder<List<SlotChange>>(
          stream: widget.database.select(widget.database.slotChanges).watch(),
          builder:
              (BuildContext context, AsyncSnapshot<List<SlotChange>> changes) {
                if (!changes.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                return _slotList(context, courses, slots.data!, changes.data!);
              },
        );
      },
    );
  }

  Widget _slotList(
    BuildContext context,
    List<Course> courses,
    List<WeeklySlot> slots,
    List<SlotChange> changes,
  ) {
    final Map<String, Course> byId = {
      for (final Course course in courses) course.id: course,
    };
    final Map<int, List<WeeklySlot>> byDay = {};
    for (final WeeklySlot slot in slots) {
      byDay.putIfAbsent(slot.weekday, () => []).add(slot);
    }
    final List<int> days = byDay.keys.toList()..sort();
    final TextStyle? headingStyle = Theme.of(context).textTheme.titleMedium;
    final ThemeData theme = Theme.of(context);
    final DateTime today = DateTime(_now().year, _now().month, _now().day);
    final List<SlotChange> upcoming =
        changes
            .where(
              (SlotChange change) => !DateTime(
                change.date.year,
                change.date.month,
                change.date.day,
              ).isBefore(today),
            )
            .toList()
          ..sort((SlotChange a, SlotChange b) => a.date.compareTo(b.date));

    return ListView(
      padding: const EdgeInsets.only(bottom: 96),
      children: [
        if (upcoming.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
            child: Text('Upcoming changes', style: headingStyle),
          ),
          for (final SlotChange change in upcoming)
            ListTile(
              leading: CircleAvatar(
                child: Icon(switch (change.kind) {
                  SlotChangeKind.cancelled => LucideIcons.circle_x,
                  SlotChangeKind.moved => LucideIcons.calendar_clock,
                  SlotChangeKind.added => LucideIcons.calendar_plus,
                }),
              ),
              title: Text(
                '${_changeLabel(change.kind)} · '
                '${byId[change.courseId]?.code ?? 'Unknown course'}',
              ),
              subtitle: Text(
                '${MaterialLocalizations.of(context).formatCompactDate(change.date)}'
                '${change.startMinute == null || change.endMinute == null ? '' : ' · ${formatMinutes(context, change.startMinute!)} – '
                          '${formatMinutes(context, change.endMinute!)}'}',
              ),
              trailing: IconButton(
                tooltip: 'Remove change',
                icon: Icon(LucideIcons.trash, color: theme.colorScheme.error),
                onPressed: () => _deleteChange(context, change),
              ),
            ),
        ],
        for (final int day in days) ...[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
            child: Text(weekdayLabel(day), style: headingStyle),
          ),
          for (final WeeklySlot slot in byDay[day]!)
            ListTile(
              leading: CircleAvatar(
                child: Text(byId[slot.courseId]?.code.substring(0, 1) ?? '?'),
              ),
              title: Text(
                byId.containsKey(slot.courseId)
                    ? '${byId[slot.courseId]!.code} · '
                          '${byId[slot.courseId]!.title}'
                    : 'Unknown course',
              ),
              subtitle: Text(
                '${formatMinutes(context, slot.startMinute)} – '
                '${formatMinutes(context, slot.endMinute)}'
                '${(slot.room ?? '').isEmpty ? '' : ' · ${slot.room}'}',
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    tooltip: 'One-off change',
                    icon: const Icon(LucideIcons.calendar_clock),
                    onPressed: () => _changeSlot(context, courses, slot),
                  ),
                  IconButton(
                    tooltip: 'Edit class',
                    icon: const Icon(LucideIcons.pencil),
                    onPressed: () => _editSlot(context, courses, slot),
                  ),
                  IconButton(
                    tooltip: 'Delete class',
                    icon: Icon(
                      LucideIcons.trash,
                      color: theme.colorScheme.error,
                    ),
                    onPressed: () => _deleteSlot(context, slot),
                  ),
                ],
              ),
            ),
        ],
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({
    required this.title,
    required this.message,
    required this.buttonLabel,
    required this.onPressed,
  });

  final String title;
  final String message;
  final String buttonLabel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                LucideIcons.calendar_days,
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
                icon: const Icon(LucideIcons.plus),
                label: Text(buttonLabel),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
