import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:material_ui/material_ui.dart';

import 'core/db/database.dart';
import 'core/theme/app_theme.dart';
import 'features/attendance/attendance_screen.dart';
import 'features/cats/cat_screen.dart';
import 'features/settings/settings_screen.dart';
import 'features/timetable/timetable_screen.dart';

/// Root of the HoldCourse app.
class HoldCourseApp extends StatelessWidget {
  const HoldCourseApp({super.key, required this.database, this.now});

  final AppDatabase database;

  /// Injectable clock for tests. Production uses the device clock.
  final DateTime Function()? now;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HoldCourse',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      home: _AppShell(database: database, now: now),
    );
  }
}

class _AppShell extends StatefulWidget {
  const _AppShell({required this.database, this.now});

  final AppDatabase database;
  final DateTime Function()? now;

  @override
  State<_AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<_AppShell> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: switch (_selected) {
        0 => TimetableScreen(database: widget.database, now: widget.now),
        1 => AttendanceScreen(
          database: widget.database,
          now: widget.now,
          onOpenSettings: () => setState(() => _selected = 3),
          onOpenTimetable: () => setState(() => _selected = 0),
        ),
        2 => CatScreen(
          database: widget.database,
          onOpenSettings: () => setState(() => _selected = 3),
          onOpenTimetable: () => setState(() => _selected = 0),
        ),
        3 => SettingsScreen(database: widget.database, now: widget.now),
        _ => const SizedBox.shrink(),
      },
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selected,
        onDestinationSelected: (int index) {
          setState(() => _selected = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(LucideIcons.calendar_days),
            label: 'Timetable',
          ),
          NavigationDestination(
            icon: Icon(LucideIcons.square_check),
            label: 'Attendance',
          ),
          NavigationDestination(
            icon: Icon(LucideIcons.chart_bar),
            label: 'CATs',
          ),
          NavigationDestination(
            icon: Icon(LucideIcons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
