import 'package:material_ui/material_ui.dart';

import 'core/theme/app_theme.dart';
import 'features/home/home_shell.dart';

/// Root of the HoldCourse app.
class HoldCourseApp extends StatelessWidget {
  const HoldCourseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HoldCourse',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      home: const HomeShell(),
    );
  }
}
