# AGENTS.md

Instructions for anyone (human or agent) working in this repository.

## What this is

HoldCourse: native Android app (Flutter + Dart, Supabase for auth/central data,
Drift for local storage) for students to track timetable, attendance and CATs.
Mode 1 (self-assessment) is the current target. Mode 2 (institutional QR
check-in) is paused.

Read `docs/SPEC.md`, `docs/HOLDCOURSE_NOTES.md`, `docs/QUICK_CHECKIN_SPEC.md`
and `docs/DECISIONS.md` before changing behaviour. `docs/DECISIONS.md` wins
where it contradicts a spec.

## Environment

- Development happens on an arm64 Android phone.
- **Flutter is not installed locally** and cannot be: the Linux SDK is
  x64-only. Use `dart` (arm64, at `/root/tools/dart-sdk/bin/dart`) for
  `dart format` and pure-Dart tests.
- `flutter analyze`, `flutter test` and `flutter build apk --debug` run on
  GitHub Actions for every push (`.github/workflows/ci.yml`, Flutter pinned to
  3.50.0). The debug APK is uploaded as the `app-debug-apk` artifact.
- Memory is tight (~3.5 GB). Do not start heavy or parallel processes.

## Layout

```
lib/app.dart              root widget, theme wiring
lib/core/                 cross-feature code (theme, later: db, sync)
lib/features/<feature>/   one folder per feature
test/                     tests mirroring lib/
android/                  generated from Flutter 3.50 templates; change only when needed
docs/                     specs and decisions
```

## Rules

- No fake, seeded or placeholder data in shipped code. Empty states instead.
- No `TODO` comments, no `print`/`debugPrint` in shipped code.
- No emoji icons. Icons come from `flutter_lucide`, snake_case names
  (`square_check`, `circle_check`, `house`, `ellipsis`, `chart_bar`, `wand`,
  `trash`). Nothing named `grid`; use `grid_3x3`.
- Material widgets and colours come from `package:material_ui/material_ui.dart`
  (Flutter 3.50 moved Material there) and from `Theme.of(context)`. Never
  hardcode a colour that should follow light/dark.
- Small commits with a clear message. Keep the tree clean between steps.
- Do not add a feature that is not in the specs. Ask first.
- Accessibility is a requirement, not a follow-up: text scaling, contrast,
  screen readers, reduced motion.

## Verification

Before committing, run:

```
dart format --output=none --set-exit-if-changed lib test
```

Formatting must be clean, because CI fails on it. Anything that needs Flutter
is verified by pushing and reading the CI result.
