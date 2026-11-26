import 'package:drift/drift.dart' show Value;
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:hold_course/core/db/database.dart';
import 'package:hold_course/features/cats/cat_dialog.dart';
import 'package:hold_course/features/cats/target_dialog.dart';
import 'package:holdcourse_domain/holdcourse_domain.dart';
import 'package:material_ui/material_ui.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

/// CAT entries, weighted standing and per-course target-grade calculator.
class CatScreen extends StatelessWidget {
  const CatScreen({
    super.key,
    required this.database,
    required this.onOpenSettings,
    required this.onOpenTimetable,
  });

  final AppDatabase database;
  final VoidCallback onOpenSettings;
  final VoidCallback onOpenTimetable;

  Stream<_CatData> _watch() {
    return Rx.combineLatest3(
      database.select(database.courses).watch(),
      database.select(database.catEntries).watch(),
      database.select(database.appSettings).watch(),
      (
        List<Course> courses,
        List<CatEntry> entries,
        List<AppSetting> settings,
      ) {
        return _CatData(courses: courses, entries: entries, settings: settings);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<_CatData>(
      stream: _watch(),
      builder: (BuildContext context, AsyncSnapshot<_CatData> snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final _CatData data = snapshot.data!;
        if (data.settings.isEmpty) {
          return _messageScreen(
            context: context,
            title: 'Set up this semester',
            message:
                'CATs need your semester setup before they can calculate '
                'your standing.',
            buttonLabel: 'Open settings',
            onPressed: onOpenSettings,
          );
        }
        if (data.courses.isEmpty) {
          return _messageScreen(
            context: context,
            title: 'No courses yet',
            message: 'Add a course before recording CAT marks.',
            buttonLabel: 'Open timetable',
            onPressed: onOpenTimetable,
          );
        }
        return _buildCats(context, data);
      },
    );
  }

  Widget _messageScreen({
    required BuildContext context,
    required String title,
    required String message,
    required String buttonLabel,
    required VoidCallback onPressed,
  }) {
    return Scaffold(
      appBar: AppBar(title: const Text('CATs')),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  LucideIcons.chart_bar,
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

  Widget _buildCats(BuildContext context, _CatData data) {
    final AppSetting settings = data.settings.first;
    final List<Course> courses = [...data.courses]
      ..sort((Course a, Course b) => a.code.compareTo(b.code));

    return Scaffold(
      appBar: AppBar(title: const Text('CATs')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 4, 12),
            child: Text(
              'Final grade: CATs ${settings.catWeight}% · '
              'exam ${settings.examWeight}%',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          for (final Course course in courses)
            _courseCard(context, data, course, settings),
        ],
      ),
    );
  }

  Widget _courseCard(
    BuildContext context,
    _CatData data,
    Course course,
    AppSetting settings,
  ) {
    final ThemeData theme = Theme.of(context);
    final List<CatEntry> entries =
        data.entries
            .where((CatEntry entry) => entry.courseId == course.id)
            .toList()
          ..sort((CatEntry a, CatEntry b) => a.title.compareTo(b.title));
    final CatStanding standing = CatStanding.fromEntries(
      entries.map(
        (CatEntry entry) => ScoreEntry(
          label: entry.title,
          score: entry.marks,
          total: entry.total,
          weight: entry.weight,
        ),
      ),
    );
    final int? target = course.targetPercent;
    final GradeTarget? projection = target == null
        ? null
        : GradeTarget(
            targetPercent: target.toDouble(),
            catWeight: settings.catWeight.toDouble(),
            examWeight: settings.examWeight.toDouble(),
            catPercentage: standing.percentage,
          );

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            title: Text('${course.code} · ${course.title}'),
            subtitle: Text(
              standing.percentage == null
                  ? 'No scored entries yet'
                  : 'CAT standing ${standing.percentage!.round()}%',
            ),
            trailing: IconButton(
              tooltip: 'Set target grade',
              icon: const Icon(LucideIcons.target),
              onPressed: () => _setTarget(context, course),
            ),
          ),
          if (projection != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Text(
                _projectionLabel(projection),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: projection.isReachable
                      ? null
                      : theme.colorScheme.error,
                ),
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Text(
                'Set a target to see the exam score you need.',
                style: theme.textTheme.bodyMedium,
              ),
            ),
          for (final CatEntry entry in entries)
            ListTile(
              leading: CircleAvatar(
                child: Text(
                  entry.marks == entry.marks.roundToDouble()
                      ? '${entry.marks.round()}'
                      : '${entry.marks}',
                ),
              ),
              title: Text(entry.title),
              subtitle: Text(
                '${entry.marks}/${entry.total} · weight ${entry.weight}'
                '${entry.date == null ? '' : ' · ${MaterialLocalizations.of(context).formatCompactDate(entry.date!)}'}',
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    tooltip: 'Edit entry',
                    icon: const Icon(LucideIcons.pencil),
                    onPressed: () => _editEntry(context, entry),
                  ),
                  IconButton(
                    tooltip: 'Delete entry',
                    icon: Icon(
                      LucideIcons.trash,
                      color: theme.colorScheme.error,
                    ),
                    onPressed: () => _deleteEntry(context, entry),
                  ),
                ],
              ),
            ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: theme.colorScheme.primaryContainer,
              child: Icon(
                LucideIcons.plus,
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
            title: const Text('Add CAT entry'),
            onTap: () => _addEntry(context, course),
          ),
        ],
      ),
    );
  }

  String _projectionLabel(GradeTarget projection) {
    final double? needed = projection.examPercentNeeded;
    if (needed == null) {
      return 'Add CAT marks to calculate the exam score you need.';
    }
    if (!projection.isReachable) {
      return 'Target unreachable: ${needed.round()}% in the exam needed.';
    }
    return 'Exam needed for your target: ${needed.round()}%';
  }

  Future<void> _setTarget(BuildContext context, Course course) async {
    final int? target = await showTargetDialog(
      context,
      courseLabel: '${course.code} · ${course.title}',
      initial: course.targetPercent,
    );
    if (target == null) {
      return;
    }
    await (database.update(database.courses)
          ..where((row) => row.id.equals(course.id)))
        .write(CoursesCompanion(targetPercent: Value(target)));
  }

  Future<void> _addEntry(BuildContext context, Course course) async {
    final CatEntryFormResult? result = await showCatDialog(context);
    if (result == null) {
      return;
    }
    await database
        .into(database.catEntries)
        .insert(
          CatEntriesCompanion.insert(
            id: Uuid().v4(),
            courseId: course.id,
            title: result.title,
            marks: result.marks,
            total: result.total,
            weight: result.weight,
            date: Value(result.date),
          ),
        );
  }

  Future<void> _editEntry(BuildContext context, CatEntry entry) async {
    final CatEntryFormResult? result = await showCatDialog(
      context,
      initial: entry,
    );
    if (result == null) {
      return;
    }
    await (database.update(
      database.catEntries,
    )..where((row) => row.id.equals(entry.id))).write(
      CatEntriesCompanion(
        title: Value(result.title),
        marks: Value(result.marks),
        total: Value(result.total),
        weight: Value(result.weight),
        date: Value(result.date),
      ),
    );
  }

  Future<void> _deleteEntry(BuildContext context, CatEntry entry) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete this entry?'),
          content: Text('${entry.title} will be removed from this course.'),
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
      await database.delete(database.catEntries).delete(entry);
    }
  }
}

class _CatData {
  const _CatData({
    required this.courses,
    required this.entries,
    required this.settings,
  });

  final List<Course> courses;
  final List<CatEntry> entries;
  final List<AppSetting> settings;
}
