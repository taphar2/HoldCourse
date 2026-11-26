import 'package:drift/drift.dart' show Value;
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:hold_course/core/db/database.dart';
import 'package:hold_course/features/timetable/add_course_dialog.dart';
import 'package:hold_course/features/timetable/add_slot_dialog.dart';
import 'package:hold_course/features/timetable/time_labels.dart';
import 'package:material_ui/material_ui.dart';
import 'package:uuid/uuid.dart';

/// The weekly timetable. It starts empty: nothing is ever seeded.
class TimetableScreen extends StatefulWidget {
  const TimetableScreen({super.key, required this.database});

  final AppDatabase database;

  @override
  State<TimetableScreen> createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  Future<void> _addCourse(BuildContext context) async {
    final NewCourseDetails? details = await showAddCourseDialog(context);
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
            createdAt: DateTime.now(),
          ),
        );
  }

  Future<void> _addSlot(BuildContext context, List<Course> courses) async {
    final NewSlotDetails? details = await showAddSlotDialog(context, courses);
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
        return _slotList(context, courses, slots.data!);
      },
    );
  }

  Widget _slotList(
    BuildContext context,
    List<Course> courses,
    List<WeeklySlot> slots,
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

    return ListView(
      padding: const EdgeInsets.only(bottom: 96),
      children: [
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
              trailing: IconButton(
                tooltip: 'Delete class',
                icon: Icon(LucideIcons.trash, color: theme.colorScheme.error),
                onPressed: () => _deleteSlot(context, slot),
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
