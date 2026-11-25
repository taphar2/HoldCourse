/// A one-off change to a session that the weekly timetable would otherwise
/// produce.
///
/// Make-up lectures use [added]: they are extra sessions for a course on a
/// date the regular timetable does not cover. See `docs/DECISIONS.md`.
enum SlotChangeKind {
  /// The session does not happen on this date.
  cancelled,

  /// The session happens at a different time on this date.
  moved,

  /// An extra session that is not part of the weekly timetable.
  added,
}
