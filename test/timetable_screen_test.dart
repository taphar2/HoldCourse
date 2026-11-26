import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hold_course/app.dart';
import 'package:hold_course/core/db/database.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  testWidgets('a new install shows an empty timetable', (tester) async {
    await tester.pumpWidget(HoldCourseApp(database: database));
    await tester.pumpAndSettle();

    expect(find.text('HoldCourse'), findsOneWidget);
    expect(find.text('No timetable yet'), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsNothing);
    await _unmount(tester);
  });

  testWidgets('courses and weekly classes appear in the timetable', (
    tester,
  ) async {
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
            room: const Value('Room 201'),
          ),
        );

    await tester.pumpWidget(HoldCourseApp(database: database));
    await tester.pumpAndSettle();

    expect(find.text('No timetable yet'), findsNothing);
    expect(find.text('Monday'), findsOneWidget);
    expect(find.textContaining('CS 310'), findsOneWidget);
    expect(find.textContaining('08:00'), findsOneWidget);
    expect(find.textContaining('Room 201'), findsOneWidget);
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
