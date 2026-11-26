import 'dart:async';

import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:material_ui/material_ui.dart';

import 'core/auth/auth_service.dart';
import 'core/db/database.dart';
import 'core/theme/app_theme.dart';
import 'features/attendance/attendance_screen.dart';
import 'features/auth/auth_screen.dart';
import 'features/cats/cat_screen.dart';
import 'features/settings/settings_screen.dart';
import 'features/timetable/timetable_screen.dart';

/// Root of the HoldCourse app.
class HoldCourseApp extends StatelessWidget {
  const HoldCourseApp({
    super.key,
    required this.database,
    required this.auth,
    this.now,
  });

  final AppDatabase database;
  final AuthService auth;

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
      home: AuthGate(database: database, auth: auth, now: now),
    );
  }
}

/// Keeps the app behind a HoldCourse account until Supabase reports a session.
class AuthGate extends StatefulWidget {
  const AuthGate({
    super.key,
    required this.database,
    required this.auth,
    this.now,
  });

  final AppDatabase database;
  final AuthService auth;
  final DateTime Function()? now;

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  AuthSession? _session;
  bool _checking = true;
  StreamSubscription<AuthSession?>? _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = widget.auth.watchSession().listen(
      (AuthSession? session) {
        if (!mounted) {
          return;
        }
        setState(() => _session = session);
      },
      onError: (Object _) {
        if (!mounted) {
          return;
        }
        setState(() => _session = null);
      },
    );
    _refresh();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  Future<void> _refresh() async {
    AuthSession? session;
    try {
      session = await widget.auth.currentSession();
    } catch (_) {
      session = null;
    }
    if (!mounted) {
      return;
    }
    setState(() {
      _session = session;
      _checking = false;
    });
  }

  void _clearSession() {
    if (!mounted) {
      return;
    }
    setState(() => _session = null);
  }

  Future<void> _signOut() async {
    try {
      await widget.auth.signOut();
    } catch (_) {
      // The local session is still cleared so the student can sign in again.
      _clearSession();
      return;
    }
    _clearSession();
  }

  @override
  Widget build(BuildContext context) {
    if (_checking) {
      return Scaffold(
        body: Center(
          child: Semantics(
            label: 'Checking account',
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }
    if (_session == null) {
      return AuthScreen(auth: widget.auth, onAuthenticated: _refresh);
    }
    return _AppShell(
      database: widget.database,
      now: widget.now,
      onSignOut: _signOut,
    );
  }
}

class _AppShell extends StatefulWidget {
  const _AppShell({required this.database, required this.onSignOut, this.now});

  final AppDatabase database;
  final Future<void> Function() onSignOut;
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
        3 => SettingsScreen(
          database: widget.database,
          now: widget.now,
          onSignOut: widget.onSignOut,
        ),
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
