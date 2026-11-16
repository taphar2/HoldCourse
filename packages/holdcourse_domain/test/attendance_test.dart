import 'package:holdcourse_domain/holdcourse_domain.dart';
import 'package:test/test.dart';

void main() {
  group('AttendanceSummary.fromStatuses', () {
    test('counts each status separately', () {
      final summary = AttendanceSummary.fromStatuses(const [
        AttendanceStatus.present,
        AttendanceStatus.present,
        AttendanceStatus.absent,
        AttendanceStatus.unmarked,
      ]);

      expect(summary.present, 2);
      expect(summary.absent, 1);
      expect(summary.unmarked, 1);
      expect(summary.scheduled, 4);
      expect(summary.countedAbsences, 2);
      expect(summary.percentage, closeTo(50, 1e-9));
    });
  });

  group('percentage', () {
    test('is null before any session', () {
      const summary = AttendanceSummary(present: 0, absent: 0, unmarked: 0);

      expect(summary.percentage, isNull);
      expect(summary.scheduled, 0);
    });

    test('counts unmarked sessions as absences', () {
      const summary = AttendanceSummary(present: 5, absent: 0, unmarked: 1);

      expect(summary.percentage, closeTo(83.333, 0.001));
      expect(summary.countedAbsences, 1);
    });
  });

  group('meetsThreshold', () {
    test('passes when above the threshold', () {
      const summary = AttendanceSummary(present: 8, absent: 2, unmarked: 0);

      expect(summary.meetsThreshold(75), isTrue);
    });

    test('passes on the boundary', () {
      const summary = AttendanceSummary(present: 9, absent: 3, unmarked: 0);

      expect(summary.percentage, closeTo(75, 1e-9));
      expect(summary.meetsThreshold(75), isTrue);
    });

    test('fails below the threshold', () {
      const summary = AttendanceSummary(present: 7, absent: 3, unmarked: 0);

      expect(summary.meetsThreshold(75), isFalse);
    });

    test('treats a new course as passing', () {
      const summary = AttendanceSummary(present: 0, absent: 0, unmarked: 0);

      expect(summary.meetsThreshold(75), isTrue);
    });
  });

  group('classesCanBeMissed', () {
    test('is null before any session', () {
      const summary = AttendanceSummary(present: 0, absent: 0, unmarked: 0);

      expect(summary.classesCanBeMissed(75), isNull);
    });

    test('is zero when the allowance is used up', () {
      const summary = AttendanceSummary(present: 8, absent: 2, unmarked: 0);

      expect(summary.classesCanBeMissed(75), 0);
    });

    test('counts the remaining allowance', () {
      const summary = AttendanceSummary(present: 9, absent: 1, unmarked: 0);

      expect(summary.classesCanBeMissed(75), 2);
    });

    test('an unmarked session uses the allowance', () {
      const summary = AttendanceSummary(present: 9, absent: 0, unmarked: 1);

      expect(summary.classesCanBeMissed(75), 2);
    });

    test('a 100% threshold allows nothing', () {
      const summary = AttendanceSummary(present: 5, absent: 0, unmarked: 0);

      expect(summary.classesCanBeMissed(100), 0);
    });

    test('a zero threshold has no limit', () {
      const summary = AttendanceSummary(present: 1, absent: 9, unmarked: 0);

      expect(summary.classesCanBeMissed(0), isNull);
    });
  });

  group('classesNeededToRecover', () {
    test('is zero when already above the threshold', () {
      const summary = AttendanceSummary(present: 8, absent: 2, unmarked: 0);

      expect(summary.classesNeededToRecover(75), 0);
    });

    test('counts the classes needed from 70%', () {
      const summary = AttendanceSummary(present: 7, absent: 3, unmarked: 0);

      expect(summary.classesNeededToRecover(75), 2);
    });

    test('counts the classes needed from 60%', () {
      const summary = AttendanceSummary(present: 6, absent: 4, unmarked: 0);

      expect(summary.classesNeededToRecover(75), 6);
    });

    test('is null when the threshold can never be reached', () {
      const summary = AttendanceSummary(present: 9, absent: 1, unmarked: 0);

      expect(summary.classesNeededToRecover(100), isNull);
    });
  });
}
