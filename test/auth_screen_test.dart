import 'package:drift/native.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hold_course/app.dart';
import 'package:hold_course/core/auth/auth_service.dart';
import 'package:hold_course/core/db/database.dart';
import 'package:material_ui/material_ui.dart';

import 'support/fake_auth.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  testWidgets('valid credentials sign in and open the app', (tester) async {
    final FakeAuthService auth = FakeAuthService();
    addTearDown(auth.dispose);
    await tester.pumpWidget(HoldCourseApp(database: database, auth: auth));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('auth-email-field')), findsOneWidget);
    await tester.enterText(
      find.byKey(const Key('auth-email-field')),
      'student@example.com',
    );
    await tester.enterText(
      find.byKey(const Key('auth-password-field')),
      'password123',
    );
    await tester.tap(find.byKey(const Key('auth-submit')));
    await tester.pumpAndSettle();

    expect(auth.signedInEmail, 'student@example.com');
    expect(find.byType(NavigationBar), findsOneWidget);
    await _unmount(tester);
  });

  testWidgets('sign-up stores the student ID for reference', (tester) async {
    final FakeAuthService auth = FakeAuthService();
    addTearDown(auth.dispose);
    await tester.pumpWidget(HoldCourseApp(database: database, auth: auth));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('auth-toggle')));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const Key('auth-email-field')),
      'new@example.com',
    );
    await tester.enterText(
      find.byKey(const Key('auth-password-field')),
      'password123',
    );
    await tester.enterText(
      find.byKey(const Key('auth-student-id-field')),
      'S123456',
    );
    await tester.tap(find.byKey(const Key('auth-submit')));
    await tester.pumpAndSettle();

    expect(auth.signedUpEmail, 'new@example.com');
    expect(auth.signedUpStudentId, 'S123456');
    expect(find.byType(NavigationBar), findsOneWidget);
    await _unmount(tester);
  });

  testWidgets('a build without Supabase explains why sign-in is closed', (
    tester,
  ) async {
    await tester.pumpWidget(
      HoldCourseApp(database: database, auth: const UnconfiguredAuthService()),
    );
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const Key('auth-email-field')),
      'student@example.com',
    );
    await tester.enterText(
      find.byKey(const Key('auth-password-field')),
      'password123',
    );
    await tester.tap(find.byKey(const Key('auth-submit')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('auth-error')), findsOneWidget);
    expect(find.textContaining('SUPABASE_URL'), findsOneWidget);
    await _unmount(tester);
  });

  testWidgets('signing out returns to the sign-in screen', (tester) async {
    final FakeAuthService auth = signedInAuth();
    addTearDown(auth.dispose);
    await tester.pumpWidget(HoldCourseApp(database: database, auth: auth));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(LucideIcons.settings));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('sign-out-button')));
    await tester.pumpAndSettle();

    expect(auth.signedOut, isTrue);
    expect(find.byKey(const Key('auth-email-field')), findsOneWidget);
    await _unmount(tester);
  });
}

/// Drift closes its watched queries on a zero-delay timer. Unmounting inside
/// the test gives that timer a chance to run before the test framework checks
/// for leftovers.
Future<void> _unmount(WidgetTester tester) async {
  await tester.pumpWidget(const SizedBox.shrink());
  await tester.pump(const Duration(milliseconds: 1));
}
