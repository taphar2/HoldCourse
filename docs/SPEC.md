# HoldCourse: Mode 1 (Self-Assessment) Spec

Native Android app for LIU BScIT Year 3 students (later other students) to track timetable, attendance and CATs. Student controls everything; no third-party monitoring.

## Stack
- Flutter + Dart
- Supabase (Auth + central DB for ALL core app data)
- Drift for local/offline storage
- Play Store distribution via native Flutter build

## Auth
- Sign-up needs a working, verifiable email. Student ID is for reference only (not verified).
- Login via Student ID or email + password.
- Login always goes through HoldCourse, whatever storage the student picks.

## Timetable and calendar
- Views: Daily / Weekly / Monthly / Full Semester.
- Pre-loaded with the author's Year 3 Mon-Fri schedule.
- Non-class days, public holidays and exam period are excluded from possible sessions.
- Key academic events are editable.
- Edit Timetable flow: add/edit/remove courses and weekly slots. Permanent vs one-off change. Edits affect future occurrences only.
- New-student onboarding: upload timetable PDF/image/.md, AI extracts, student reviews and corrects. Manual entry is the fallback. Same for academic calendar.
- App provides a copyable prompt so students can produce the canonical .md format with their own AI tool.

## Attendance
- Self-mark Present/Absent with notes.
- Per-course %, 75% threshold, ranking page.

## CAT tracking
- Multiple entries per course (CAT1, CAT2, assignments), each with weight and score.
- Global split, default CATs 40% / exam 60%, editable.
- Target-grade calculator: exam score needed per course.

## Course Hub (per course)
- Next-lecture countdown.
- AI overview from an uploaded course outline (editable). Re-upload regenerates; warn before overwriting manual edits.
- Materials library: auto-organized by semester week plus custom folders.
- Assignment tracker: due date, priority, notes, file attachment.
- Multiple named notes per course.
- Search per course (titles/filenames or full content).
- Attendance % and CAT standing shown here.
- Removing a course archives its hub for 7 days, then deletes.
- Repeated course codes carry content over, labeled by semester.

## Other features
- Daily notes/to-dos.
- Analytics: attendance trend, CAT trend, weekly workload, cross-course comparison.
- PDF + Excel export (presentable, date-range filter, excludes private notes).
- Semester switcher; each semester auto-archived as a labeled backup.
- Backup/restore: same-account recovery and migration to a new account. Preview first; conflicts flagged for the student to choose. Weekly backup reminder, configurable.
- Feedback/bug report: category, description, optional screenshot, auto device/app info.

## Notifications (each has on/off + custom timing where relevant)
Class reminders, assignment due dates, low attendance warning, CAT entry reminder, target grade unreachable alert, attendance streak nudge, to-do reminders, semester event reminders, daily morning summary.

## Offline
- Works offline and syncs later: attendance + notes, cached timetable/calendar, CAT scores, notes/to-dos, assignments, event edits.
- Needs connectivity: login, file uploads, AI generation, push delivery.
- Multi-device sync conflicts: student picks which version to keep (no last-write-wins).

## AI features and monetization
- No free built-in AI. Student either brings their own API key (BYOK) or subscribes to a paid plan.
- BYOK key: encrypted at rest, used server-side only, masked in UI, validated with a real test call before saving.

## File storage (files only; core data is always central)
1. Free: student's own Supabase bucket
2. Free: student's Google Drive (appDataFolder)
3. Paid: HoldCourse-managed storage

## Account deletion
- Central data, managed files and subscription deleted; files in the student's own storage are untouched.
- 30-day grace period before permanent.

## Accessibility
Font scaling, high-contrast/colorblind mode, screen reader support, reduced motion.

## Design principles
- Every technical feature has specific in-app step-by-step instructions.
- Light/dark mode.
- Icons: flutter_lucide uses snake_case names (e.g. square_check, circle_check, house, ellipsis, chart_bar, wand, trash). No emoji icons.

## Build status (as of Nov 2026)
Built earlier by other tools (needs re-verification, not compiled): onboarding (10 screens), dashboard, Course Hub shell/Overview/Materials, attendance screens 13-16 (two pending fixes: wire screen 14 to screen 15 as a widget; screen 16 hardcoded color must read from theme).
Not started: Course Hub Assignments/Notes, CAT tracking, Analytics, Backup/Restore, Export, Settings.
