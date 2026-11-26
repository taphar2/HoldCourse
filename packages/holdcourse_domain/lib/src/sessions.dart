import 'timetable.dart';

/// A recurring weekly class.
final class SessionRule {
  const SessionRule({
    required this.id,
    required this.courseId,
    required this.weekday,
    required this.startMinute,
    required this.endMinute,
  });

  final String id;
  final String courseId;

  /// 1 = Monday through 7 = Sunday, matching [DateTime.weekday].
  final int weekday;
  final int startMinute;
  final int endMinute;
}

/// A one-off change on a single date.
final class SessionChange {
  const SessionChange({
    required this.courseId,
    required this.date,
    required this.kind,
    this.ruleId,
    this.startMinute,
    this.endMinute,
  });

  final String courseId;
  final DateTime date;
  final SlotChangeKind kind;

  /// The weekly rule being cancelled or moved. Null for an added class.
  final String? ruleId;
  final int? startMinute;
  final int? endMinute;
}

/// One class that actually took place, derived rather than stored.
final class ClassSession {
  const ClassSession({
    required this.courseId,
    required this.date,
    required this.startMinute,
    required this.endMinute,
    this.ruleId,
  });

  final String courseId;
  final DateTime date;
  final int startMinute;
  final int endMinute;

  /// Null for a one-off added class.
  final String? ruleId;

  /// Identity of a session, used to attach an attendance mark.
  String get key =>
      '$courseId/${date.year}-${date.month}-${date.day}/$startMinute';
}

DateTime _day(DateTime value) => DateTime(value.year, value.month, value.day);

bool _sameDay(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;

/// Derives every session that has finished between the semester dates and
/// [now]. Sessions still in progress are excluded, so an unmarked class is
/// only shown once it is over.
///
/// [SlotChangeKind.added] creates an extra session. [cancelled] removes the
/// matching weekly session, and [moved] replaces its times on that date.
List<ClassSession> deriveSessions({
  required Iterable<SessionRule> rules,
  required Iterable<SessionChange> changes,
  required DateTime semesterStart,
  required DateTime semesterEnd,
  required DateTime now,
}) {
  final DateTime first = _day(semesterStart);
  final DateTime last = _day(semesterEnd);
  if (last.isBefore(first)) {
    throw ArgumentError.value(semesterEnd, 'semesterEnd', 'before start');
  }

  final Map<String, List<SessionChange>> changesByDay = {};
  for (final SessionChange change in changes) {
    changesByDay
        .putIfAbsent(
          _day(change.date).toIso8601String(),
          () => <SessionChange>[],
        )
        .add(change);
  }

  final List<ClassSession> sessions = <ClassSession>[];
  final int nowMinute = now.hour * 60 + now.minute;

  for (
    DateTime date = first;
    !date.isAfter(last) && !date.isAfter(_day(now));
    date = date.add(const Duration(days: 1))
  ) {
    final List<SessionChange> todayChanges =
        changesByDay[date.toIso8601String()] ?? const <SessionChange>[];

    for (final SessionRule rule in rules) {
      if (rule.weekday != date.weekday) {
        continue;
      }
      final SessionChange? change = todayChanges
          .cast<SessionChange?>()
          .firstWhere(
            (SessionChange? candidate) =>
                candidate?.ruleId == rule.id &&
                candidate?.kind != SlotChangeKind.added,
            orElse: () => null,
          );
      if (change?.kind == SlotChangeKind.cancelled) {
        continue;
      }
      final int start = change?.startMinute ?? rule.startMinute;
      final int end = change?.endMinute ?? rule.endMinute;
      if (_sameDay(date, now) && end > nowMinute) {
        continue;
      }
      sessions.add(
        ClassSession(
          courseId: rule.courseId,
          date: date,
          startMinute: start,
          endMinute: end,
          ruleId: rule.id,
        ),
      );
    }

    for (final SessionChange change in todayChanges) {
      if (change.kind != SlotChangeKind.added ||
          (change.startMinute == null || change.endMinute == null)) {
        continue;
      }
      if (_sameDay(date, now) && change.endMinute! > nowMinute) {
        continue;
      }
      sessions.add(
        ClassSession(
          courseId: change.courseId,
          date: date,
          startMinute: change.startMinute!,
          endMinute: change.endMinute!,
        ),
      );
    }
  }

  sessions.sort((ClassSession a, ClassSession b) {
    final int byDate = a.date.compareTo(b.date);
    return byDate != 0 ? byDate : a.startMinute.compareTo(b.startMinute);
  });
  return sessions;
}
