import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:holdcourse_domain/holdcourse_domain.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables.dart';

part 'database.g.dart';

/// The local database.
///
/// Every table starts empty: nothing is seeded at install time, because the
/// timetable is blank until the student adds courses. See `docs/DECISIONS.md`.
@DriftDatabase(
  tables: [
    Courses,
    WeeklySlots,
    SlotChanges,
    AttendanceMarks,
    CatEntries,
    AppSettings,
  ],
)
class AppDatabase extends _$AppDatabase {
  /// Opens an in-memory database, for tests.
  AppDatabase.forTesting(super.executor);

  /// Opens the database file used by the app.
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}

QueryExecutor _openConnection() {
  return LazyDatabase(() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File(p.join(directory.path, 'hold_course.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
