import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hold_course/core/db/database.dart';
import 'package:hold_course/features/settings/settings_screen.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  testWidgets('semester dates and threshold can be saved', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: SettingsScreen(
          database: database,
          now: () => DateTime(2026, 11, 16),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(OutlinedButton, 'Start: Choose date'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(OutlinedButton, 'End: Choose date'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('threshold-field')), '80');
    await _saveSettings(tester);
    await tester.pumpAndSettle();

    final AppSetting settings =
        (await database.select(database.appSettings).get()).single;
    expect(settings.semesterStart, DateTime(2026, 11, 16));
    expect(settings.semesterEnd, DateTime(2026, 11, 16));
    expect(settings.attendanceThreshold, 80);
    await _unmount(tester);
  });

  testWidgets('an existing threshold can be edited', (tester) async {
    await database
        .into(database.appSettings)
        .insert(
          AppSettingsCompanion.insert(
            semesterStart: DateTime(2026, 9, 1),
            semesterEnd: DateTime(2026, 12, 20),
          ),
        );

    await tester.pumpWidget(
      MaterialApp(
        home: SettingsScreen(
          database: database,
          now: () => DateTime(2026, 11, 16),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('75'), findsOneWidget);
    await tester.enterText(find.byKey(const Key('threshold-field')), '70');
    await _saveSettings(tester);
    await tester.pumpAndSettle();

    final AppSetting settings =
        (await database.select(database.appSettings).get()).single;
    expect(settings.attendanceThreshold, 70);
    await _unmount(tester);
  });

  testWidgets('the grade split is locked after setup', (tester) async {
    await database
        .into(database.appSettings)
        .insert(
          AppSettingsCompanion.insert(
            semesterStart: DateTime(2026, 9, 1),
            semesterEnd: DateTime(2026, 12, 20),
            catWeight: const Value(30),
            examWeight: const Value(70),
            onboardingComplete: const Value(true),
          ),
        );

    await tester.pumpWidget(
      MaterialApp(
        home: SettingsScreen(
          database: database,
          now: () => DateTime(2026, 11, 16),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      tester.widget<TextField>(find.byKey(const Key('cat-field'))).enabled,
      isFalse,
    );
    await tester.enterText(find.byKey(const Key('threshold-field')), '60');
    await _saveSettings(tester);
    await tester.pumpAndSettle();

    final AppSetting settings =
        (await database.select(database.appSettings).get()).single;
    expect(settings.attendanceThreshold, 60);
    expect(settings.catWeight, 30);
    expect(settings.examWeight, 70);
    expect(settings.semesterStart, DateTime(2026, 9, 1));
    await _unmount(tester);
  });
}

/// Drift closes its watched queries on a zero-delay timer. Unmounting inside
/// the test gives that timer a chance to run before the test framework checks
/// for leftovers.
Future<void> _saveSettings(WidgetTester tester) async {
  const Key key = Key('save-settings');
  await tester.ensureVisible(find.byKey(key));
  await tester.tap(find.byKey(key));
  await tester.pumpAndSettle();
}

Future<void> _unmount(WidgetTester tester) async {
  await tester.pumpWidget(const SizedBox.shrink());
  await tester.pump(const Duration(milliseconds: 1));
}
