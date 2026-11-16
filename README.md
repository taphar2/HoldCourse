# HoldCourse

Native Android app (Flutter + Dart, Supabase, Drift) for tracking timetable,
attendance and CATs, starting with LIU BScIT Year 3.

The student controls their own data. There is no third-party monitoring.

## Documents

- `docs/SPEC.md` - Mode 1 (self-assessment) specification.
- `docs/QUICK_CHECKIN_SPEC.md` - Mode 2 (institutional QR check-in), paused until Mode 1 is shipped.

## Builds

Builds happen on GitHub Actions so no local Flutter install is required:

1. Push to any branch.
2. Open the Actions run for that commit.
3. Download the `app-debug-apk` artifact and install it on the phone.

The workflow runs `flutter analyze`, `flutter test` and `flutter build apk --debug`.

## Status

Early scaffolding. See `docs/SPEC.md` for the full scope.
