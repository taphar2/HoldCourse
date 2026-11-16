/// How one past class session was recorded.
enum AttendanceStatus {
  present,

  /// The student explicitly marked themselves absent.
  absent,

  /// The session happened but the student never marked it. Counted as an
  /// absence in percentages, but shown separately so it can be corrected.
  unmarked,
}

/// Attendance totals for a single course.
///
/// Every session that has already happened is in the denominator, marked or
/// not. This is the rule agreed in `docs/DECISIONS.md`.
final class AttendanceSummary {
  const AttendanceSummary({
    required this.present,
    required this.absent,
    required this.unmarked,
  }) : assert(present >= 0),
       assert(absent >= 0),
       assert(unmarked >= 0);

  /// Builds a summary from individually recorded sessions.
  factory AttendanceSummary.fromStatuses(Iterable<AttendanceStatus> statuses) {
    var present = 0;
    var absent = 0;
    var unmarked = 0;
    for (final status in statuses) {
      switch (status) {
        case AttendanceStatus.present:
          present++;
        case AttendanceStatus.absent:
          absent++;
        case AttendanceStatus.unmarked:
          unmarked++;
      }
    }
    return AttendanceSummary(
      present: present,
      absent: absent,
      unmarked: unmarked,
    );
  }

  final int present;
  final int absent;
  final int unmarked;

  /// Sessions that have already happened for this course.
  int get scheduled => present + absent + unmarked;

  /// Sessions that count against the student: marked absent plus unmarked.
  int get countedAbsences => absent + unmarked;

  /// Attendance as a percentage of [scheduled], or null before any session.
  double? get percentage => scheduled == 0 ? null : present * 100 / scheduled;

  /// Whether attendance is at or above [thresholdPercent].
  ///
  /// A course with no sessions yet counts as meeting the threshold so the app
  /// does not warn before the semester starts.
  bool meetsThreshold(int thresholdPercent) {
    assert(thresholdPercent >= 0 && thresholdPercent <= 100);
    final double? value = percentage;
    if (value == null) {
      return true;
    }
    // Compare in integers so 75% is never missed by a floating-point hair.
    return present * 100 >= thresholdPercent * scheduled;
  }

  /// How many more sessions can be missed and still meet [thresholdPercent].
  ///
  /// Returns null when there is nothing to judge yet, or when the threshold is
  /// zero and therefore has no limit.
  int? classesCanBeMissed(int thresholdPercent) {
    assert(thresholdPercent >= 0 && thresholdPercent <= 100);
    if (scheduled == 0 || thresholdPercent == 0) {
      return null;
    }
    final int allowedAbsences =
        present * (100 - thresholdPercent) ~/ thresholdPercent;
    final int remaining = allowedAbsences - countedAbsences;
    return remaining < 0 ? 0 : remaining;
  }

  /// How many consecutive future attendances are needed to reach
  /// [thresholdPercent].
  ///
  /// Returns 0 when already there, and null when it cannot be reached (for
  /// example a 100% threshold with an existing absence).
  int? classesNeededToRecover(int thresholdPercent) {
    assert(thresholdPercent >= 0 && thresholdPercent <= 100);
    if (meetsThreshold(thresholdPercent)) {
      return 0;
    }
    if (thresholdPercent >= 100) {
      return null;
    }
    final int shortfall = thresholdPercent * scheduled - present * 100;
    final int perClass = 100 - thresholdPercent;
    return (shortfall + perClass - 1) ~/ perClass;
  }
}
