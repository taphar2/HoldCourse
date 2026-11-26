import 'package:material_ui/material_ui.dart';

import 'core/db/database.dart';
import 'core/theme/app_theme.dart';
import 'features/timetable/timetable_screen.dart';

/// Root of the HoldCourse app.
class HoldCourseApp extends StatelessWidget {
  const HoldCourseApp({super.key, required this.database});

  final AppDatabase database;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HoldCourse',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      home: TimetableScreen(database: database),
    );
  }
}
