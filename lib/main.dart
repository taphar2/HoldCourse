import 'package:material_ui/material_ui.dart';

import 'app.dart';
import 'core/db/database.dart';

void main() {
  runApp(HoldCourseApp(database: AppDatabase()));
}
