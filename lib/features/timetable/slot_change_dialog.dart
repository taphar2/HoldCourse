import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:hold_course/core/db/database.dart';
import 'package:hold_course/features/timetable/time_labels.dart';
import 'package:holdcourse_domain/holdcourse_domain.dart';
import 'package:material_ui/material_ui.dart';

/// What the student chose for one date.
final class SlotChangeFormResult {
  const SlotChangeFormResult({
    required this.courseId,
    required this.kind,
    required this.date,
    this.startMinute,
    this.endMinute,
  });

  final String courseId;
  final SlotChangeKind kind;
  final DateTime date;
  final int? startMinute;
  final int? endMinute;
}

/// A cancellation, move or make-up class on one date only.
Future<SlotChangeFormResult?> showSlotChangeDialog(
  BuildContext context, {
  required List<Course> courses,
  required String? courseId,
  required List<SlotChangeKind> kinds,
  required DateTime initialDate,
  required int initialStartMinute,
  required int initialEndMinute,
}) {
  return showDialog<SlotChangeFormResult>(
    context: context,
    builder: (BuildContext context) {
      return _SlotChangeDialog(
        courses: courses,
        courseId: courseId,
        kinds: kinds,
        initialDate: initialDate,
        initialStartMinute: initialStartMinute,
        initialEndMinute: initialEndMinute,
      );
    },
  );
}

class _SlotChangeDialog extends StatefulWidget {
  const _SlotChangeDialog({
    required this.courses,
    required this.courseId,
    required this.kinds,
    required this.initialDate,
    required this.initialStartMinute,
    required this.initialEndMinute,
  });

  final List<Course> courses;
  final String? courseId;
  final List<SlotChangeKind> kinds;
  final DateTime initialDate;
  final int initialStartMinute;
  final int initialEndMinute;

  @override
  State<_SlotChangeDialog> createState() => _SlotChangeDialogState();
}

class _SlotChangeDialogState extends State<_SlotChangeDialog> {
  late String _courseId = widget.courseId ?? widget.courses.first.id;
  late SlotChangeKind _kind = widget.kinds.first;
  late DateTime _date = _day(widget.initialDate);
  late TimeOfDay _start = _timeOf(widget.initialStartMinute);
  late TimeOfDay _end = _timeOf(widget.initialEndMinute);
  String? _error;

  DateTime _day(DateTime value) => DateTime(value.year, value.month, value.day);

  TimeOfDay _timeOf(int minutes) =>
      TimeOfDay(hour: minutes ~/ 60, minute: minutes % 60);

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(_date.year - 1),
      lastDate: DateTime(_date.year + 2),
      helpText: 'Choose the date',
    );
    if (picked != null) {
      setState(() {
        _date = _day(picked);
        _error = null;
      });
    }
  }

  Future<void> _pickTime({required bool isStart}) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStart ? _start : _end,
    );
    if (picked == null) {
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
    final int start = minutesOf(_start);
    final int end = minutesOf(_end);
    if (_kind != SlotChangeKind.cancelled && end <= start) {
      setState(() => _error = 'The end time must be after the start time');
      return;
    }
    Navigator.of(context).pop(
      SlotChangeFormResult(
        courseId: _courseId,
        kind: _kind,
        date: _date,
        startMinute: _kind == SlotChangeKind.cancelled ? null : start,
        endMinute: _kind == SlotChangeKind.cancelled ? null : end,
      ),
    );
  }

  String _label(SlotChangeKind kind) {
    return switch (kind) {
      SlotChangeKind.cancelled => 'Cancel class',
      SlotChangeKind.moved => 'Move class',
      SlotChangeKind.added => 'Make-up class',
    };
  }

  IconData _icon(SlotChangeKind kind) {
    return switch (kind) {
      SlotChangeKind.cancelled => LucideIcons.circle_x,
      SlotChangeKind.moved => LucideIcons.calendar_clock,
      SlotChangeKind.added => LucideIcons.calendar_plus,
    };
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool needsTime = _kind != SlotChangeKind.cancelled;
    return AlertDialog(
      title: Text(
        widget.kinds.contains(SlotChangeKind.added)
            ? 'Add make-up class'
            : 'One-off class change',
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'This affects one date only. Past attendance stays unchanged.',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            if (widget.courseId == null)
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
            if (widget.courseId == null) const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: _pickDate,
              icon: const Icon(LucideIcons.calendar_days),
              label: Text(
                'Date: ${MaterialLocalizations.of(context).formatCompactDate(_date)}',
              ),
            ),
            const SizedBox(height: 16),
            SegmentedButton<SlotChangeKind>(
              segments: [
                for (final SlotChangeKind kind in widget.kinds)
                  ButtonSegment<SlotChangeKind>(
                    value: kind,
                    label: Text(_label(kind)),
                    icon: Icon(_icon(kind)),
                  ),
              ],
              selected: {_kind},
              onSelectionChanged: (Set<SlotChangeKind> selected) {
                setState(() {
                  _kind = selected.first;
                  _error = null;
                });
              },
            ),
            if (needsTime) ...[
              const SizedBox(height: 12),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Starts'),
                trailing: TextButton.icon(
                  onPressed: () => _pickTime(isStart: true),
                  icon: const Icon(LucideIcons.clock),
                  label: Text(formatMinutes(context, minutesOf(_start))),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Ends'),
                trailing: TextButton.icon(
                  onPressed: () => _pickTime(isStart: false),
                  icon: const Icon(LucideIcons.clock),
                  label: Text(formatMinutes(context, minutesOf(_end))),
                ),
              ),
            ],
            if (_error != null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  _error!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.error,
                  ),
                ),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(onPressed: _save, child: const Text('Save')),
      ],
    );
  }
}
