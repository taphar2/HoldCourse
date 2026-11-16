# Decisions

Dated log of choices that change or clarify the specs in this folder.
Newest first. Specs stay as written; where a decision contradicts a spec line,
the decision wins and the line is quoted here.

---

## 2026-11-16 — Timetable is blank by default

**Decided by:** project owner.

`docs/SPEC.md` says "Pre-loaded with the author's Year 3 Mon-Fri schedule."
That no longer applies for Mode 1.

- Every student starts with an **empty timetable** and adds their own courses
  and weekly slots.
- The Year 3 LIU schedule is a placeholder used only for testing and
  reference, never shipped as seeded data in the app.
- Consequence: onboarding must lead into manual entry (or the AI upload path)
  rather than showing a pre-filled week. No timetable rows are created at
  install time.

---

## 2026-11-16 — Tooling on the phone

**Decided by:** project owner.

- Flutter is not installed locally: Flutter's Linux SDK is x64-only and this
  device is arm64. Builds and analysis run on GitHub Actions.
- The arm64 Dart SDK is installed locally for `dart format` and pure-Dart
  tests only.
- Consequence: no widget tests or `flutter analyze` can run on the phone, so
  every Flutter change is verified by CI, not locally.
