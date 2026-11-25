import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hold_course/core/db/database.dart';
import 'package:holdcourse_domain/holdcourse_domain.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  test('a fresh database is completely empty', () async {
    expect(await db.select(db.courses).get(), isEmpty);
    expect(await db.select(db.weeklySlots).get(), isEmpty);
    expect(await db.select(db.slotChanges).get(), isEmpty);
    expect(await db.select(db.attendanceMarks).get(), isEmpty);
    expect(await db.select(db.catEntries).get(), isEmpty);
    expect(await db.select(db.appSettings).get(), isEmpty);
  });

  test('round-trips a course, its weekly slot and an attendance mark',
      () async {
    final DateTime created = DateTime(2026, 11, 16, 8);

    await db.into(db.courses).insert(
          CoursesCompanion.insert(
            id: 'course-1',
            code: 'CS 310',
            title: 'Database Systems',
            createdAt: Value(created),
          ),
        );
    await db.into(db.weeklySlots).insert(
          WeeklySlotsCompanion.insert(
            id: 'slot-1',
            courseId: 'course-1',
            weekday: DateTime.monday,
            startMinute: 480,
            endMinute: 600,
          ),
        );

    final DateTime monday = DateTime(2026, 11, 16);
    await db.into(db.attendanceMarks).insert(
          AttendanceMarksCompanion.insert(
            courseId: 'course-1',
            date: monday,
            startMinute: 480,
            status: AttendanceStatus.present,
            markedAt: Value(created),
          ),
        );

    final List<AttendanceMark> marks =
        await db.select(db.attendanceMarks).get();
    expect(marks, hasLength(1));
    expect(marks.single.status, AttendanceStatus.present);
    expect(marks.single.date, monday);

    final WeeklySlot slot = (await db.select(db.weeklySlots).get()).single;
    expect(slot.weekday, DateTime.monday);
    expect(slot.endMinute, 600);
  });

  test('one-off make-up lectures and CAT entries are stored', () async {
    final DateTime created = DateTime(2026, 11, 16, 8);
    await db.into(db.courses).insert(
          CoursesCompanion.insert(
            id: 'course-1',
            code: 'CS 310',
            title: 'Database Systems',
            createdAt: Value(created),
          ),
        );

    await db.into(db.slotChanges).insert(
          SlotChangesCompanion.insert(
            id: 'change-1',
            courseId: 'course-1',
            date: DateTime(2026, 11, 21),
            kind: SlotChangeKind.added,
            startMinute: const Value(600),
            endMinute: const Value(720),
          ),
        );
    await db.into(db.catEntries).insert(
          CatEntriesCompanion.insert(
            id: 'cat-1',
            courseId: 'course-1',
            title: 'CAT 1',
            marks: 12,
            total: 20,
            weight: 15,
          ),
        );

    expect(
      (await db.select(db.slotChanges).get()).single.kind,
      SlotChangeKind.added,
    );
    final CatEntry entry = (await db.select(db.catEntries).get()).single;
    expect(entry.marks, 12);
    expect(entry.total, 20);
  });

  test('settings hold semester dates and the agreed defaults', () async {
    final DateTime start = DateTime(2026, 9, 1);
    final DateTime end = DateTime(2026, 12, 20);
    await db.into(db.appSettings).insert(
          AppSettingsCompanion.insert(
            semesterStart: start,
            semesterEnd: end,
          ),
        );

    final AppSetting settings = (await db.select(db.appSettings).get()).single;
    expect(settings.semesterStart, start);
    expect(settings.attendanceThreshold, 75);
    expect(settings.catWeight, 40);
    expect(settings.examWeight, 60);
    expect(settings.onboardingComplete, isFalse);
  });

  test('deleting a course removes its dependent rows', () async {
    final DateTime created = DateTime(2026, 11, 16, 8);
    await db.into(db.courses).insert(
          CoursesCompanion.insert(
            id: 'course-1',
            code: 'CS 310',
            title: 'Database Systems',
            createdAt: Value(created),
          ),
        );
    await db.into(db.weeklySlots).insert(
          WeeklySlotsCompanion.insert(
            id: 'slot-1',
            courseId: 'course-1',
            weekday: DateTime.monday,
            startMinute: 480,
            endMinute: 600,
          ),
        );

    await (db.delete(db.courses)..where((row) => row.id.equals('course-1'))).go();

    expect(await db.select(db.courses).get(), isEmpty);
    expect(await db.select(db.weeklySlots).get(), isEmpty);
  });
}
