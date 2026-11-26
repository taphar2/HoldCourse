import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:hold_course/core/db/database.dart';
import 'package:holdcourse_domain/holdcourse_domain.dart';
import 'package:material_ui/material_ui.dart';

/// What the student chose in the marking dialog.
final class AttendanceFormResult {
  const AttendanceFormResult({required this.status, required this.note});

  final AttendanceStatus status;
  final String note;
}

/// Marks one class as present or absent, with an optional note.
Future<AttendanceFormResult?> showAttendanceDialog(
  BuildContext context, {
  required String courseLabel,
  required String when,
  AttendanceMark? existing,
}) {
  return showDialog<AttendanceFormResult>(
    context: context,
    builder: (BuildContext context) {
      return _AttendanceDialog(
        courseLabel: courseLabel,
        when: when,
        existing: existing,
      );
    },
  );
}

class _AttendanceDialog extends StatefulWidget {
  const _AttendanceDialog({
    required this.courseLabel,
    required this.when,
    this.existing,
  });

  final String courseLabel;
  final String when;
  final AttendanceMark? existing;

  @override
  State<_AttendanceDialog> createState() => _AttendanceDialogState();
}

class _AttendanceDialogState extends State<_AttendanceDialog> {
  late AttendanceStatus _status =
      widget.existing?.status ?? AttendanceStatus.present;
  late final TextEditingController _note = TextEditingController(
    text: widget.existing?.note ?? '',
  );

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Mark attendance'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.courseLabel,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(widget.when, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 20),
            SegmentedButton<AttendanceStatus>(
              segments: const [
                ButtonSegment(
                  value: AttendanceStatus.present,
                  label: Text('Present'),
                  icon: Icon(LucideIcons.square_check),
                ),
                ButtonSegment(
                  value: AttendanceStatus.absent,
                  label: Text('Absent'),
                  icon: Icon(LucideIcons.circle_x),
                ),
              ],
              selected: {_status},
              onSelectionChanged: (Set<AttendanceStatus> selected) {
                setState(() => _status = selected.first);
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _note,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Note (optional)',
                border: OutlineInputBorder(),
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
        FilledButton(
          onPressed: () => Navigator.of(
            context,
          ).pop(AttendanceFormResult(status: _status, note: _note.text.trim())),
          child: const Text('Save'),
        ),
      ],
    );
  }
}
