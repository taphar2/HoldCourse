import 'package:drift/drift.dart' show Value;
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:hold_course/core/db/database.dart';
import 'package:material_ui/material_ui.dart';

/// Semester dates and marking rules.
///
/// Until sign-up exists, this is where the student completes setup. Dates and
/// the CAT/exam split are locked once setup is saved; the threshold stays
/// editable. See `docs/DECISIONS.md`.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
    required this.database,
    required this.onSignOut,
    this.now,
  });

  final AppDatabase database;
  final Future<void> Function() onSignOut;
  final DateTime Function()? now;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late final TextEditingController _threshold;
  late final TextEditingController _cat;
  late final TextEditingController _exam;
  DateTime? _start;
  DateTime? _end;
  bool _loaded = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _threshold = TextEditingController(text: '75');
    _cat = TextEditingController(text: '40');
    _exam = TextEditingController(text: '60');
  }

  @override
  void dispose() {
    _threshold.dispose();
    _cat.dispose();
    _exam.dispose();
    super.dispose();
  }

  DateTime _now() => widget.now?.call() ?? DateTime.now();

  Future<void> _pickDate({required bool isStart}) async {
    final DateTime initial = isStart
        ? (_start ?? _now())
        : (_end ?? _start ?? _now());
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(initial.year - 2),
      lastDate: DateTime(initial.year + 2),
      helpText: isStart ? 'Choose semester start' : 'Choose semester end',
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _start = DateTime(picked.year, picked.month, picked.day);
        } else {
          _end = DateTime(picked.year, picked.month, picked.day);
        }
        _error = null;
      });
    }
  }

  Future<void> _save(List<AppSetting> existing, bool locked) async {
    final int? threshold = int.tryParse(_threshold.text.trim());
    if (threshold == null || threshold < 0 || threshold > 100) {
      setState(() => _error = 'Enter a threshold between 0 and 100.');
      return;
    }

    if (!locked) {
      if (_start == null || _end == null) {
        setState(() => _error = 'Choose both semester dates first.');
        return;
      }
      if (_end!.isBefore(_start!)) {
        setState(() => _error = 'The semester cannot end before it starts.');
        return;
      }
      final int? cat = int.tryParse(_cat.text.trim());
      final int? exam = int.tryParse(_exam.text.trim());
      if (cat == null || exam == null || cat + exam != 100) {
        setState(() => _error = 'CAT and exam weights must add up to 100.');
        return;
      }
    }

    if (existing.isEmpty) {
      await widget.database
          .into(widget.database.appSettings)
          .insert(
            AppSettingsCompanion.insert(
              semesterStart: _start!,
              semesterEnd: _end!,
              attendanceThreshold: Value(threshold),
              catWeight: Value(int.parse(_cat.text.trim())),
              examWeight: Value(int.parse(_exam.text.trim())),
              onboardingComplete: const Value(true),
            ),
          );
    } else if (locked) {
      await (widget.database.update(widget.database.appSettings)
            ..where((row) => row.id.equals(0)))
          .write(AppSettingsCompanion(attendanceThreshold: Value(threshold)));
    } else {
      await (widget.database.update(
        widget.database.appSettings,
      )..where((row) => row.id.equals(0))).write(
        AppSettingsCompanion(
          semesterStart: Value(_start!),
          semesterEnd: Value(_end!),
          attendanceThreshold: Value(threshold),
          catWeight: Value(int.parse(_cat.text.trim())),
          examWeight: Value(int.parse(_exam.text.trim())),
          onboardingComplete: const Value(true),
        ),
      );
    }
  }

  String _dateLabel(BuildContext context, DateTime? date) {
    if (date == null) {
      return 'Choose date';
    }
    return MaterialLocalizations.of(context).formatCompactDate(date);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<AppSetting>>(
      stream: widget.database.select(widget.database.appSettings).watch(),
      builder: (BuildContext context, AsyncSnapshot<List<AppSetting>> snapshot) {
        final List<AppSetting> settings = snapshot.data ?? const [];
        if (!_loaded && settings.isNotEmpty) {
          _start = settings.first.semesterStart;
          _end = settings.first.semesterEnd;
          _threshold.text = settings.first.attendanceThreshold.toString();
          _cat.text = settings.first.catWeight.toString();
          _exam.text = settings.first.examWeight.toString();
          _loaded = true;
        }
        final bool locked =
            settings.isNotEmpty && settings.first.onboardingComplete;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Semester settings'),
            actions: [
              IconButton(
                key: const Key('sign-out-button'),
                onPressed: widget.onSignOut,
                icon: const Icon(LucideIcons.log_out),
                tooltip: 'Sign out',
              ),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Semester dates',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Attendance uses these dates to work out which classes '
                    'have already happened. Unmarked classes count as absent.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: locked ? null : () => _pickDate(isStart: true),
                    icon: const Icon(LucideIcons.calendar_days),
                    label: Text('Start: ${_dateLabel(context, _start)}'),
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton.icon(
                    onPressed: locked ? null : () => _pickDate(isStart: false),
                    icon: const Icon(LucideIcons.calendar_days),
                    label: Text('End: ${_dateLabel(context, _end)}'),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    key: const Key('threshold-field'),
                    controller: _threshold,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Attendance threshold (%)',
                      helperText: 'Default is 75%. You can change this later.',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Final grade split',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    locked ? 'Set once during setup and locked afterwards.' : 'Used for every course. The two weights add up to 100.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    key: const Key('cat-field'),
                    controller: _cat,
                    enabled: !locked,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'CATs (%)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    key: const Key('exam-field'),
                    controller: _exam,
                    enabled: !locked,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Exam (%)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  if (_error != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      _error!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    key: const Key('save-settings'),
                    onPressed: () => _save(settings, locked),
                    icon: const Icon(LucideIcons.square_check),
                    label: const Text('Save settings'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
