/// One graded component, such as CAT1, CAT2 or an assignment.
///
/// Scores are stored as marks out of a total (12 out of 20), never as a
/// percentage, and each entry carries its own weight.
final class ScoreEntry {
  const ScoreEntry({
    required this.label,
    required this.score,
    required this.total,
    required this.weight,
  }) : assert(total > 0),
       assert(score >= 0),
       assert(score <= total),
       assert(weight >= 0);

  final String label;
  final double score;
  final double total;

  /// Weight of this entry within the CAT portion of the final grade.
  final double weight;

  /// Score as a fraction of the total, between 0 and 1.
  double get fraction => score / total;
}

/// Weighted standing across the CAT-type entries of one course.
final class CatStanding {
  const CatStanding._({required this.percentage, required this.totalWeight});

  /// Computes the weighted percentage of the entries that carry weight.
  factory CatStanding.fromEntries(Iterable<ScoreEntry> entries) {
    var weighted = 0.0;
    var weight = 0.0;
    for (final ScoreEntry entry in entries) {
      if (entry.weight <= 0) {
        continue;
      }
      weighted += entry.fraction * entry.weight;
      weight += entry.weight;
    }
    return CatStanding._(
      percentage: weight == 0 ? null : weighted / weight * 100,
      totalWeight: weight,
    );
  }

  /// CAT percentage, or null when no entry carries weight.
  final double? percentage;

  /// Sum of the weights that were used.
  final double totalWeight;
}

/// Final-grade projection for one course, given a target grade.
final class GradeTarget {
  const GradeTarget({
    required this.targetPercent,
    required this.catWeight,
    required this.examWeight,
    this.catPercentage,
  }) : assert(targetPercent >= 0 && targetPercent <= 100),
       assert(catWeight >= 0),
       assert(examWeight >= 0);

  /// Grade the student wants, as a percentage of the final mark.
  final double targetPercent;

  /// Share of the final grade carried by CATs, e.g. 40.
  final double catWeight;

  /// Share of the final grade carried by the exam, e.g. 60.
  final double examWeight;

  /// CAT percentage achieved so far, or null when nothing is scored yet.
  final double? catPercentage;

  /// Points of the final grade already secured from CATs, e.g. 27.5 of 40.
  double? get securedPercent {
    final double? cat = catPercentage;
    return cat == null ? null : cat * catWeight / 100;
  }

  /// Exam percentage needed to reach [targetPercent].
  ///
  /// Null when CAT marks are missing or the exam carries no weight. A value
  /// above 100 means the target cannot be reached.
  double? get examPercentNeeded {
    final double? secured = securedPercent;
    if (secured == null || examWeight <= 0) {
      return null;
    }
    final double needed = (targetPercent - secured) / (examWeight / 100);
    return needed <= 0 ? 0 : needed;
  }

  /// Whether the target is still achievable with a perfect exam.
  bool get isReachable {
    final double? needed = examPercentNeeded;
    return needed != null && needed <= 100;
  }
}
