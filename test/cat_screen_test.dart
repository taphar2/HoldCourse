import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hold_course/app.dart';
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

  Future<void> seedSettingsAndCourse({int? target}) async {
    await database
        .into(database.appSettings)
        .insert(
          AppSettingsCompanion.insert(
            semesterStart: DateTime(2026, 9, 1),
            semesterEnd: DateTime(2026, 12, 20),
            onboardingComplete: const Value(true),
          ),
        );
    await database
        .into(database.courses)
        .insert(
          CoursesCompanion.insert(
            id: 'course-1',
            code: 'CS 310',
            title: 'Database Systems',
            createdAt: DateTime(2026, 9, 1),
            targetPercent: Value(target),
          ),
        );
  }

  Future<void> openCats(WidgetTester tester) async {
    await tester.pumpWidget(
      HoldCourseApp(auth: signedInAuth(), database: database),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(LucideIcons.chart_bar));
    await tester.pumpAndSettle();
  }

  testWidgets('weighted standing and exam target are shown', (tester) async {
    await seedSettingsAndCourse(target: 80);
    await database
        .into(database.catEntries)
        .insert(
          CatEntriesCompanion.insert(
            id: 'entry-1',
            courseId: 'course-1',
            title: 'CAT 1',
            marks: 12,
            total: 20,
            weight: 15,
          ),
        );
    await database
        .into(database.catEntries)
        .insert(
          CatEntriesCompanion.insert(
            id: 'entry-2',
            courseId: 'course-1',
            title: 'Assignment',
            marks: 18,
            total: 20,
            weight: 10,
          ),
        );

    await openCats(tester);

    expect(find.text('CAT standing 72%'), findsOneWidget);
    expect(find.text('Exam needed for your target: 85%'), findsOneWidget);
    await _unmount(tester);
  });

  testWidgets('entries and targets can be saved', (tester) async {
    await seedSettingsAndCourse();
    await openCats(tester);

    await tester.tap(find.text('Add CAT entry'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('cat-title-field')), 'CAT 1');
    await tester.enterText(find.byKey(const Key('cat-marks-field')), '12');
    await tester.enterText(find.byKey(const Key('cat-total-field')), '20');
    await tester.enterText(find.byKey(const Key('cat-weight-field')), '15');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    final List<CatEntry> entries = await database
        .select(database.catEntries)
        .get();
    expect(entries, hasLength(1));
    expect(entries.single.title, 'CAT 1');
    expect(entries.single.marks, 12);
    expect(entries.single.total, 20);
    expect(entries.single.weight, 15);

    await tester.tap(find.byIcon(LucideIcons.target));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('target-field')), '75');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    final Course course =
        (await database.select(database.courses).get()).single;
    expect(course.targetPercent, 75);
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
