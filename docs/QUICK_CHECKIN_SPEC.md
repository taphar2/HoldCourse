# HoldCourse: Quick Check-in (Mode 2, institutional)

Status: paused. Not compiled. Build after Mode 1.

## Flow
Scan lecture-room QR -> deep link holdcourse://check-in?s=<sessionId>&t=<token> (or https://<domain>/c/<sessionId>?t=<token>) -> login if needed -> Step 1 Location -> Step 2 Selfie (front camera, 3 s auto-capture, Retake) -> Step 3 auto-submit after 3 s -> receipt (name, ID, programme, course, time, selfie).

## Decisions
- Selfie is ALWAYS required.
- Identity = logged-in HoldCourse account (not typed ID).
- Build "QR opens Flutter app" now; web/mobile-page fallback later.
- Mode 2 only.
- Online-only.

## Kept from main attendance design
- QR rotates every 20-30 s; expires class end + 30 min.
- Proximity check required.
- Manual fallback: rotating code + spoken 3-digit lecturer code, 1-minute limit (exceeding flags as suspicious).
- Failed proximity -> "pending" for lecturer review.
- Disputes: 36 h window, lecturer then Registry.
- Semester freeze = read-only.

## Server checks (token validated at SUBMIT time, valid window + ~10 s grace)
- Session open and token valid.
- Account active and enrolled (enrollment date <= session date).
- Location within room geofence (low accuracy counts as failure).
- Selfie valid, <= 150 KB.
- Not already marked (second submit returns the existing receipt).
Outcomes: recorded / pending / rejected.

## Selfie policy
- Visible only to the student, the session lecturer and Registry.
- No auto face-matching; human review only.
- Deleted at dispute-window close unless disputed or flagged.
- Consent line shown. Check Uganda Data Protection and Privacy Act 2019.
- Selfies are FILES, so they follow the file-storage model.
- Only exception: camera unusable -> manual code path, flagged "no selfie".

## VPN rule
Show a VPN warning and block check-in while a VPN is connected. App detects the VPN transport (e.g. connectivity_plus). Server flags known VPN/datacenter IP ranges as pending (best effort). Web can use only the server IP check.

## Error states (each needs step-by-step help text)
Not logged in, not enrolled, token expired, session closed, location off/denied/outside/low accuracy, camera denied/unavailable, no connection, already marked, unknown.

## Abuse mitigations
Rotation + location + selfie; lecturer spot checks; mock-location flag on Android; rate limit per device/session; flag several accounts on one device; audit log of every attempt (account, session, time, accuracy, distance, outcome, device).

## Undecided ideas
- Lecturer device broadcasts a rotating Bluetooth LE token; student app scans and submits it. Caveats: no web support, iOS advertising limits, relay attack, extra permission.
- Cascade location check BT -> Wi-Fi -> GPS. Suggested: run in parallel, student app sends an evidence bundle, server decides and records which method confirmed. Fall back only when a tier is unavailable, not when it is negative.

## Open items
- Geofence radius (suggest 30 m default, or per room).
- Selfie deletion at dispute-window close OK with Registry?
- Lecturer live selfie view?
- Can lecturers disable the manual fallback per session?

## Build order
Link parser -> state machine + repository -> screens -> Supabase Edge Function for server checks -> Android App Links / holdcourse:// scheme -> later web fallback.
Flutter packages needed: camera, geolocator. Flutter 3.27+.
