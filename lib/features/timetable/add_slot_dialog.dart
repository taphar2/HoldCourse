import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:hold_course/core/db/database.dart';
import 'package:hold_course/features/timetable/time_labels.dart';
import 'package:material_ui/material_ui.dart';

/// What the student chose in the add-class form.
final class NewSlotDetails {
  const NewSlotDetails({
    required this.courseId,
    required this.weekday,
    required this.startMinute,
    required this.endMinute,
    required this.room,
  });

  final String courseId;
  final int weekday;
  final int startMinute;
  final int endMinute;
  final String room;
}

/// Asks for a recurring class. Returns null when cancelled.
Future<NewSlotDetails?> showAddSlotDialog(
  BuildContext context,
  List<Course> courses,
) async {
  if (courses.isEmpty) {
    return null;
  }
  return showDialog<NewSlotDetails>(
    context: context,
    builder: (BuildContext context) => _AddSlotDialog(courses: courses),
  );
}

class _AddSlotDialog extends StatefulWidget {
  const _AddSlotDialog({required this.courses});

  final List<Course> courses;

  @override
  State<_AddSlotDialog> createState() => _AddSlotDialogState();
}

class _AddSlotDialogState extends State<_AddSlotDialog> {
  late String _courseId = widget.courses.first.id;
  int _weekday = DateTime.monday;
  TimeOfDay _start = const TimeOfDay(hour: 8, minute: 0);
  TimeOfDay _end = const TimeOfDay(hour: 9, minute: 0);
  String? _error;
  final TextEditingController _room = TextEditingController();

  @override
  void dispose() {
    _room.dispose();
    super.dispose();
  }

  Future<void> _pickTime({required bool isStart}) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStart ? _start : _end,
    );
    if (picked == null || !mounted) {
      return;
    }
    setState(() {
      if (isStart) {
        _start = picked;
      } else {
        _end = picked;
      }
      _error = null;
    });
  }

  void _save() {
    final int startMinute = minutesOf(_start);
    final int endMinute = minutesOf(_end);
    if (endMinute <= startMinute) {
      setState(() => _error = 'The end time must be after the start time');
      return;
    }
    Navigator.of(context).pop(
      NewSlotDetails(
        courseId: _courseId,
        weekday: _weekday,
        startMinute: startMinute,
        endMinute: endMinute,
        room: _room.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return AlertDialog(
      title: const Text('Add class'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              initialValue: _courseId,
              decoration: const InputDecoration(labelText: 'Course'),
              items: [
                for (final Course course in widget.courses)
                  DropdownMenuItem<String>(
                    value: course.id,
                    child: Text('${course.code} — ${course.title}'),
                  ),
              ],
              onChanged: (String? value) {
                if (value != null) {
                  setState(() => _courseId = value);
                }
              },
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<int>(
              initialValue: _weekday,
              decoration: const InputDecoration(labelText: 'Day'),
              items: [
                for (int day = DateTime.monday; day <= DateTime.sunday; day++)
                  DropdownMenuItem<int>(
                    value: day,
                    child: Text(weekdayLabel(day)),
                  ),
              ],
              onChanged: (int? value) {
                if (value != null) {
                  setState(() => _weekday = value);
                }
              },
            ),
            const SizedBox(height: 12),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Starts'),
              trailing: TextButton.icon(
                onPressed: () => _pickTime(isStart: true),
                icon: const Icon(LucideIcons.clock),
                label: Text(
                  MaterialLocalizations.of(context)
                      .formatTimeOfDay(_start, alwaysUse24HourFormat: true),
                ),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Ends'),
              trailing: TextButton.icon(
                onPressed: () => _pickTime(isStart: false),
                icon: const Icon(LucideIcons.clock),
                label: Text(
                  MaterialLocalizations.of(context)
                      .formatTimeOfDay(_end, alwaysUse24HourFormat: true),
                ),
              ),
            ),
            TextField(
              controller: _room,
              decoration: const InputDecoration(labelText: 'Room (optional)'),
            ),
            if (_error != null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(_error!, style: TextStyle(color: colors.error)),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(onPressed: _save, child: const Text('Add')),
      ],
    );
  }
}
