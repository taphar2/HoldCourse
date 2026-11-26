import 'package:drift/native.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hold_course/app.dart';
import 'package:hold_course/core/db/database.dart';
import 'package:holdcourse_domain/holdcourse_domain.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  testWidgets('unmarked classes are prompted and can be marked', (
    tester,
  ) async {
    await database
        .into(database.appSettings)
        .insert(
          AppSettingsCompanion.insert(
            semesterStart: DateTime(2026, 11, 16),
            semesterEnd: DateTime(2026, 11, 22),
          ),
        );
    await database
        .into(database.courses)
        .insert(
          CoursesCompanion.insert(
            id: 'course-1',
            code: 'CS 310',
            title: 'Database Systems',
            createdAt: DateTime(2026, 11, 16),
          ),
        );
    await database
        .into(database.weeklySlots)
        .insert(
          WeeklySlotsCompanion.insert(
            id: 'slot-1',
            courseId: 'course-1',
            weekday: DateTime.monday,
            startMinute: 480,
            endMinute: 600,
          ),
        );

    await tester.pumpWidget(
      HoldCourseApp(database: database, now: () => DateTime(2026, 11, 18, 18)),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(LucideIcons.square_check));
    await tester.pumpAndSettle();

    expect(find.text('1 class needs marking'), findsOneWidget);
    expect(find.textContaining('Unmarked · counted as absent'), findsOneWidget);

    await tester.tap(find.text('Mark now'));
    await tester.pumpAndSettle();
    expect(find.text('Mark attendance'), findsOneWidget);
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    final List<AttendanceMark> marks = await database
        .select(database.attendanceMarks)
        .get();
    expect(marks, hasLength(1));
    expect(marks.single.status, AttendanceStatus.present);
    expect(find.text('1 class needs marking'), findsNothing);
    expect(
      find.textContaining('1 present · 0 absent · 0 unmarked'),
      findsOneWidget,
    );
    await _unmount(tester);
  });

  testWidgets('attendance asks for semester dates before deriving classes', (
    tester,
  ) async {
    await tester.pumpWidget(
      HoldCourseApp(database: database, now: () => DateTime(2026, 11, 18, 18)),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(LucideIcons.square_check));
    await tester.pumpAndSettle();

    expect(find.text('Set your semester dates'), findsOneWidget);
    await tester.tap(find.text('Open settings'));
    await tester.pumpAndSettle();
    expect(find.text('Semester settings'), findsOneWidget);
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
