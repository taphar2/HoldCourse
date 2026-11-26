# Decisions

Dated log of choices that change or clarify the specs in this folder.
Newest first. Specs stay as written; where a decision contradicts a spec line,
the decision wins and the line is quoted here.

---

## 2026-11-26 — Supabase config and debug-signed bundle

**Decided by:** project owner.

- Sign-up/login is wired through Supabase. The project URL and anon key are
  injected with `--dart-define` from GitHub repository secrets, never committed.
- Until those secrets exist, the app shows a configuration error instead of
  letting students into local-only data.
- For now the manually built AAB is debug-signed. A Play Store upload key is
  not being generated or requested yet.

---

## 2026-11-17 — Flutter runs locally on the phone

**Decided by:** project owner. Supersedes "Tooling on the phone" below, where
it says Flutter cannot be installed.

The x64-only limit applies to Flutter's prebuilt Linux SDK tarball, not to
Flutter itself. Flutter 3.50.0 was assembled from its source tarball in
`/root/tools/flutter`, running on the arm64 Dart SDK with the arm64 engine
artifacts pinned to the 3.50.0 engine.

- `flutter analyze`, `flutter test` and `dart format` now run on the phone.
- APK builds stay on GitHub Actions: Android's `aapt2` and `zipalign` are
  x86_64-only binaries, no arm64 builds exist, and `binfmt_misc` is not
  writable, so a local Gradle build is not dependable.

---

## 2026-11-16 — Mode 1 attendance and CAT rules

**Decided by:** project owner. These are the rules the attendance and CAT
logic implements.

1. **Unmarked past classes:** shown as `unmarked`, counted as absent in
   percentages, and the student gets a reminder to mark them.
2. **CAT entries:** score is stored as marks out of a total (e.g. 12/20) and
   the app computes the percentage. Each entry carries its own weight.
3. **CAT/exam split:** one global setting, default CAT 40 / exam 60. Editable
   at sign-up only, locked afterwards.
4. **Semester dates:** entered once at sign-up for that semester.
5. **Make-up lectures:** handled by the existing one-off timetable change.
   No separate feature.
6. **Attendance threshold:** default 75%, editable by the student in settings.

**Consequences:**

- The attendance denominator is every session that has already happened,
  marked or not. `unmarked` therefore behaves like `absent` in the maths but
  stays visible in the UI.
- Two derived numbers are needed: how many more classes can be missed while
  staying at or above the threshold, and how many consecutive classes are
  needed to climb back.
- The target-grade calculation is
  `(target - CAT contribution) / exam share`, where a result above 100% means
  the target is unreachable.

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
