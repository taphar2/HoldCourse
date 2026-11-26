import 'package:drift/drift.dart';
import 'package:holdcourse_domain/holdcourse_domain.dart';

/// One course the student is taking.
///
/// Courses are archived rather than deleted so their history stays readable;
/// see `docs/SPEC.md`, "Removing a course archives its hub".
class Courses extends Table {
  TextColumn get id => text()();
  TextColumn get code => text()();
  TextColumn get title => text()();
  TextColumn get lecturer => text().nullable()();
  IntColumn get colorIndex => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get archivedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// A recurring class in the student's week.
///
/// Minutes are counted from midnight, so 08:00 is 480. Timetables start
/// empty: nothing is inserted unless the student adds it.
class WeeklySlots extends Table {
  TextColumn get id => text()();
  TextColumn get courseId =>
      text().references(Courses, #id, onDelete: KeyAction.cascade)();

  /// 1 = Monday through 7 = Sunday, matching [DateTime.weekday].
  IntColumn get weekday => integer()();
  IntColumn get startMinute => integer()();
  IntColumn get endMinute => integer()();
  TextColumn get room => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<String> get customConstraints => [
    'CHECK (weekday BETWEEN 1 AND 7)',
    'CHECK (start_minute >= 0)',
    'CHECK (end_minute > start_minute)',
  ];
}

/// A change that applies to one date only.
class SlotChanges extends Table {
  TextColumn get id => text()();
  TextColumn get courseId =>
      text().references(Courses, #id, onDelete: KeyAction.cascade)();

  /// The slot being cancelled or moved. Null for an [SlotChangeKind.added]
  /// session, which exists only on this date.
  TextColumn get slotId => text().nullable().references(
    WeeklySlots,
    #id,
    onDelete: KeyAction.cascade,
  )();
  DateTimeColumn get date => dateTime()();
  IntColumn get kind => intEnum<SlotChangeKind>()();
  IntColumn get startMinute => integer().nullable()();
  IntColumn get endMinute => integer().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// What the student recorded for one session.
///
/// Only sessions the student touched are stored. Sessions are otherwise
/// derived from [WeeklySlots] and [SlotChanges], so a timetable edit never
/// rewrites attendance history.
///
/// The primary key is the session identity: course, date and start minute.
class AttendanceMarks extends Table {
  TextColumn get courseId =>
      text().references(Courses, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get date => dateTime()();
  IntColumn get startMinute => integer()();
  IntColumn get status => intEnum<AttendanceStatus>()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get markedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {courseId, date, startMinute};
}

/// One CAT, assignment or test result, stored as marks out of a total.
class CatEntries extends Table {
  TextColumn get id => text()();
  TextColumn get courseId =>
      text().references(Courses, #id, onDelete: KeyAction.cascade)();
  TextColumn get title => text()();
  RealColumn get marks => real()();
  RealColumn get total => real()();
  RealColumn get weight => real()();
  DateTimeColumn get date => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<String> get customConstraints => [
    'CHECK (total > 0)',
    'CHECK (weight > 0)',
    'CHECK (marks >= 0 AND marks <= total)',
  ];
}

/// The single row holding semester dates and marking rules.
class AppSettings extends Table {
  /// Always 0: the check constraint keeps this table to one row.
  IntColumn get id => integer().clientDefault(() => 0)();
  DateTimeColumn get semesterStart => dateTime()();
  DateTimeColumn get semesterEnd => dateTime()();
  IntColumn get attendanceThreshold =>
      integer().withDefault(const Constant(75))();
  IntColumn get catWeight => integer().withDefault(const Constant(40))();
  IntColumn get examWeight => integer().withDefault(const Constant(60))();
  BoolColumn get onboardingComplete =>
      boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<String> get customConstraints => ['CHECK (id = 0)'];
}
