import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:hold_course/core/db/database.dart';
import 'package:material_ui/material_ui.dart';

/// What the student entered for one graded component.
final class CatEntryFormResult {
  const CatEntryFormResult({
    required this.title,
    required this.marks,
    required this.total,
    required this.weight,
    required this.date,
  });

  final String title;
  final double marks;
  final double total;
  final double weight;
  final DateTime? date;
}

/// Adds or edits one CAT, assignment or test result.
Future<CatEntryFormResult?> showCatDialog(
  BuildContext context, {
  CatEntry? initial,
}) {
  return showDialog<CatEntryFormResult>(
    context: context,
    builder: (BuildContext context) => _CatDialog(initial: initial),
  );
}

class _CatDialog extends StatefulWidget {
  const _CatDialog({this.initial});

  final CatEntry? initial;

  @override
  State<_CatDialog> createState() => _CatDialogState();
}

class _CatDialogState extends State<_CatDialog> {
  late final TextEditingController _title = TextEditingController(
    text: widget.initial?.title ?? '',
  );
  late final TextEditingController _marks = TextEditingController(
    text: widget.initial?.marks.toString() ?? '',
  );
  late final TextEditingController _total = TextEditingController(
    text: widget.initial?.total.toString() ?? '',
  );
  late final TextEditingController _weight = TextEditingController(
    text: widget.initial?.weight.toString() ?? '',
  );
  late DateTime? _date;
  String? _error;

  @override
  void initState() {
    super.initState();
    _date = widget.initial?.date;
  }

  @override
  void dispose() {
    _title.dispose();
    _marks.dispose();
    _total.dispose();
    _weight.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date ?? now,
      firstDate: DateTime(now.year - 2),
      lastDate: DateTime(now.year + 2),
      helpText: 'Choose the date (optional)',
    );
    if (picked != null) {
      setState(() => _date = DateTime(picked.year, picked.month, picked.day));
    }
  }

  void _save() {
    final String title = _title.text.trim();
    final double? marks = double.tryParse(_marks.text.trim());
    final double? total = double.tryParse(_total.text.trim());
    final double? weight = double.tryParse(_weight.text.trim());
    if (title.isEmpty) {
      setState(() => _error = 'Give this entry a name.');
      return;
    }
    if (marks == null || total == null || weight == null) {
      setState(() => _error = 'Enter numbers for marks, total and weight.');
      return;
    }
    if (total <= 0 || weight <= 0) {
      setState(() => _error = 'Total and weight must be greater than zero.');
      return;
    }
    if (marks < 0 || marks > total) {
      setState(() => _error = 'Marks must be between 0 and the total.');
      return;
    }
    Navigator.of(context).pop(
      CatEntryFormResult(
        title: title,
        marks: marks,
        total: total,
        weight: weight,
        date: _date,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return AlertDialog(
      title: Text(widget.initial == null ? 'Add CAT entry' : 'Edit CAT entry'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              key: const Key('cat-title-field'),
              controller: _title,
              decoration: const InputDecoration(
                labelText: 'Name',
                helperText: 'CAT 1, assignment, test…',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    key: const Key('cat-marks-field'),
                    controller: _marks,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Marks',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    key: const Key('cat-total-field'),
                    controller: _total,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Total',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              key: const Key('cat-weight-field'),
              controller: _weight,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Weight within CATs',
                helperText: 'For example 15 if this CAT is worth 15%.',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: _pickDate,
              icon: const Icon(LucideIcons.calendar_days),
              label: Text(
                _date == null
                    ? 'Add a date (optional)'
                    : 'Date: ${MaterialLocalizations.of(context).formatCompactDate(_date!)} (tap to change)',
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
