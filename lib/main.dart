import 'package:material_ui/material_ui.dart';

import 'app.dart';
import 'core/auth/auth_service.dart';
import 'core/config.dart';
import 'core/db/database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final AuthService auth = AppConfig.hasSupabase
      ? SupabaseAuthService(
          url: AppConfig.supabaseUrl,
          anonKey: AppConfig.supabaseAnonKey,
        )
      : const UnconfiguredAuthService();
  await auth.initialize();

  runApp(HoldCourseApp(database: AppDatabase(), auth: auth));
}
