import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:hold_course/core/db/database.dart';
import 'package:hold_course/features/timetable/time_labels.dart';
import 'package:material_ui/material_ui.dart';

/// What the student chose in the class form.
final class SlotFormResult {
  const SlotFormResult({
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

/// Asks for a recurring class, prefilled when [initial] is given.
///
/// Returns null when cancelled.
Future<SlotFormResult?> showSlotDialog(
  BuildContext context,
  List<Course> courses, {
  SlotFormResult? initial,
}) async {
  if (courses.isEmpty) {
    return null;
  }
  return showDialog<SlotFormResult>(
    context: context,
    builder: (BuildContext context) =>
        _SlotDialog(courses: courses, initial: initial),
  );
}

class _SlotDialog extends StatefulWidget {
  const _SlotDialog({required this.courses, this.initial});

  final List<Course> courses;
  final SlotFormResult? initial;

  @override
  State<_SlotDialog> createState() => _SlotDialogState();
}

class _SlotDialogState extends State<_SlotDialog> {
  late String _courseId = widget.initial?.courseId ?? widget.courses.first.id;
  late int _weekday = widget.initial?.weekday ?? DateTime.monday;
  late TimeOfDay _start = _timeOf(widget.initial?.startMinute, 8);
  late TimeOfDay _end = _timeOf(widget.initial?.endMinute, 9);
  late final TextEditingController _room;
  String? _error;

  @override
  void initState() {
    super.initState();
    _room = TextEditingController(text: widget.initial?.room ?? '');
  }

  TimeOfDay _timeOf(int? minutes, int defaultHour) {
    final int value = minutes ?? defaultHour * 60;
    return TimeOfDay(hour: value ~/ 60, minute: value % 60);
  }

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
      SlotFormResult(
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
    final bool editing = widget.initial != null;
    return AlertDialog(
      title: Text(editing ? 'Edit class' : 'Add class'),
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
        FilledButton(onPressed: _save, child: Text(editing ? 'Save' : 'Add')),
      ],
    );
  }
}
