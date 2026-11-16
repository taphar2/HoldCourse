import 'package:holdcourse_domain/holdcourse_domain.dart';
import 'package:test/test.dart';

void main() {
  group('CatStanding', () {
    test('weights each entry by its own weight', () {
      final standing = CatStanding.fromEntries(const [
        ScoreEntry(label: 'CAT1', score: 12, total: 20, weight: 15),
        ScoreEntry(label: 'CAT2', score: 14, total: 20, weight: 15),
        ScoreEntry(label: 'Assignment', score: 8, total: 10, weight: 10),
      ]);

      expect(standing.percentage, closeTo(68.75, 1e-9));
      expect(standing.totalWeight, 40);
    });

    test('ignores entries with no weight', () {
      final standing = CatStanding.fromEntries(const [
        ScoreEntry(label: 'CAT1', score: 10, total: 20, weight: 10),
        ScoreEntry(label: 'Bonus', score: 0, total: 10, weight: 0),
      ]);

      expect(standing.percentage, closeTo(50, 1e-9));
      expect(standing.totalWeight, 10);
    });

    test('is null when nothing carries weight', () {
      final standing = CatStanding.fromEntries(const [
        ScoreEntry(label: 'CAT1', score: 10, total: 20, weight: 0),
      ]);

      expect(standing.percentage, isNull);
      expect(standing.totalWeight, 0);
    });

    test('handles partial marks', () {
      final standing = CatStanding.fromEntries(const [
        ScoreEntry(label: 'CAT1', score: 12.5, total: 25, weight: 20),
      ]);

      expect(standing.percentage, closeTo(50, 1e-9));
    });
  });

  group('GradeTarget', () {
    test('computes the exam score needed', () {
      const target = GradeTarget(
        targetPercent: 70,
        catWeight: 40,
        examWeight: 60,
        catPercentage: 68.75,
      );

      expect(target.securedPercent, closeTo(27.5, 1e-9));
      expect(target.examPercentNeeded, closeTo(70.833, 0.001));
      expect(target.isReachable, isTrue);
    });

    test('needs nothing when CATs already cover the target', () {
      const target = GradeTarget(
        targetPercent: 30,
        catWeight: 40,
        examWeight: 60,
        catPercentage: 100,
      );

      expect(target.examPercentNeeded, 0);
      expect(target.isReachable, isTrue);
    });

    test('flags a target the exam cannot cover', () {
      const target = GradeTarget(
        targetPercent: 90,
        catWeight: 40,
        examWeight: 60,
        catPercentage: 20,
      );

      expect(target.examPercentNeeded, closeTo(136.667, 0.001));
      expect(target.isReachable, isFalse);
    });

    test('is unknown before any CAT is scored', () {
      const target = GradeTarget(
        targetPercent: 70,
        catWeight: 40,
        examWeight: 60,
      );

      expect(target.securedPercent, isNull);
      expect(target.examPercentNeeded, isNull);
      expect(target.isReachable, isFalse);
    });

    test('is unknown when the exam carries no weight', () {
      const target = GradeTarget(
        targetPercent: 70,
        catWeight: 100,
        examWeight: 0,
        catPercentage: 80,
      );

      expect(target.examPercentNeeded, isNull);
    });
  });
}
