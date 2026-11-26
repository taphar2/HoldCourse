import 'package:material_ui/material_ui.dart';

/// Returns a target percentage, or null when cancelled.
Future<int?> showTargetDialog(
  BuildContext context, {
  required String courseLabel,
  int? initial,
}) {
  return showDialog<int>(
    context: context,
    builder: (BuildContext context) {
      return _TargetDialog(courseLabel: courseLabel, initial: initial);
    },
  );
}

class _TargetDialog extends StatefulWidget {
  const _TargetDialog({required this.courseLabel, this.initial});

  final String courseLabel;
  final int? initial;

  @override
  State<_TargetDialog> createState() => _TargetDialogState();
}

class _TargetDialogState extends State<_TargetDialog> {
  late final TextEditingController _value = TextEditingController(
    text: widget.initial?.toString() ?? '',
  );
  String? _error;

  @override
  void dispose() {
    _value.dispose();
    super.dispose();
  }

  void _save() {
    final int? target = int.tryParse(_value.text.trim());
    if (target == null || target < 0 || target > 100) {
      setState(() => _error = 'Enter a target between 0 and 100.');
      return;
    }
    Navigator.of(context).pop(target);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return AlertDialog(
      title: const Text('Target grade'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(widget.courseLabel, style: theme.textTheme.titleMedium),
          const SizedBox(height: 16),
          TextField(
            key: const Key('target-field'),
            controller: _value,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Target (%)',
              helperText: 'What final grade do you want in this course?',
              border: OutlineInputBorder(),
            ),
          ),
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
