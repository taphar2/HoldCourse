# HoldCourse

Native Android app (Flutter + Dart, Supabase, Drift) for tracking timetable,
attendance and CATs, starting with LIU BScIT Year 3.

The student controls their own data. There is no third-party monitoring.

## Documents

- `docs/SPEC.md` - Mode 1 (self-assessment) specification.
- `docs/QUICK_CHECKIN_SPEC.md` - Mode 2 (institutional QR check-in), paused until Mode 1 is shipped.

## Builds

Builds happen on GitHub Actions so no local Flutter install is required:

1. Add repository secrets `SUPABASE_URL` and `SUPABASE_ANON_KEY` so sign-in
   works in the built app.
2. Push to any branch.
3. Open the Actions run for that commit.
4. Download the `app-debug-apk` artifact and install it on the phone.

The workflow runs `flutter analyze`, `flutter test`, the domain package tests
and `flutter build apk --debug`. The `Build AAB` workflow can be run manually
to produce a debug-signed bundle; it is not a Play Store upload key.

## Status

Mode 1 (self-assessment) MVP: account sign-in, timetable, attendance and CAT
tracking. See `docs/SPEC.md` for the full scope.
