import 'package:holdcourse_domain/holdcourse_domain.dart';
import 'package:test/test.dart';

void main() {
  final DateTime semesterStart = DateTime(2026, 11, 16);
  final DateTime semesterEnd = DateTime(2026, 11, 22);
  final DateTime now = DateTime(2026, 11, 18, 18);

  final SessionRule monday = SessionRule(
    id: 'mon',
    courseId: 'c1',
    weekday: DateTime.monday,
    startMinute: 480,
    endMinute: 600,
  );
  final SessionRule wednesday = SessionRule(
    id: 'wed',
    courseId: 'c1',
    weekday: DateTime.wednesday,
    startMinute: 600,
    endMinute: 720,
  );

  group('deriveSessions', () {
    test('generates only finished weekly classes in the semester', () {
      final List<ClassSession> sessions = deriveSessions(
        rules: [monday, wednesday],
        changes: const [],
        semesterStart: semesterStart,
        semesterEnd: semesterEnd,
        now: now,
      );

      expect(sessions.map((ClassSession s) => s.date), [
        DateTime(2026, 11, 16),
        DateTime(2026, 11, 18),
      ]);
      expect(sessions.first.key, 'c1/2026-11-16/480');
    });

    test('excludes a class still running today', () {
      final List<ClassSession> sessions = deriveSessions(
        rules: [monday],
        changes: const [],
        semesterStart: semesterStart,
        semesterEnd: semesterEnd,
        now: DateTime(2026, 11, 16, 9),
      );
      expect(sessions, isEmpty);
    });

    test('cancellation removes one occurrence only', () {
      final List<ClassSession> sessions = deriveSessions(
        rules: [monday],
        changes: [
          SessionChange(
            courseId: 'c1',
            ruleId: 'mon',
            date: DateTime(2026, 11, 16),
            kind: SlotChangeKind.cancelled,
          ),
        ],
        semesterStart: semesterStart,
        semesterEnd: semesterEnd,
        now: now,
      );
      expect(sessions, isEmpty);
    });

    test('moved uses the new time on that date', () {
      final List<ClassSession> sessions = deriveSessions(
        rules: [monday],
        changes: [
          SessionChange(
            courseId: 'c1',
            ruleId: 'mon',
            date: DateTime(2026, 11, 16),
            kind: SlotChangeKind.moved,
            startMinute: 660,
            endMinute: 780,
          ),
        ],
        semesterStart: semesterStart,
        semesterEnd: semesterEnd,
        now: now,
      );
      expect(sessions.single.startMinute, 660);
      expect(sessions.single.endMinute, 780);
    });

    test('added creates an extra class without a weekly rule', () {
      final List<ClassSession> sessions = deriveSessions(
        rules: const [],
        changes: [
          SessionChange(
            courseId: 'c2',
            date: DateTime(2026, 11, 17),
            kind: SlotChangeKind.added,
            startMinute: 900,
            endMinute: 1020,
          ),
        ],
        semesterStart: semesterStart,
        semesterEnd: semesterEnd,
        now: now,
      );
      expect(sessions.single.courseId, 'c2');
      expect(sessions.single.ruleId, isNull);
    });

    test('rejects semester dates in the wrong order', () {
      expect(
        () => deriveSessions(
          rules: const [],
          changes: const [],
          semesterStart: semesterEnd,
          semesterEnd: semesterStart,
          now: now,
        ),
        throwsArgumentError,
      );
    });
  });
}
