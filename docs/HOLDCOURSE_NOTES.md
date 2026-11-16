# HoldCourse — Project Notes

Timetable & attendance tracking app for LIU BScIT Year 3. Evolved from the earlier "Lecture Ledger" prototype (renamed to HoldCourse).

---

## 1. Final Spec v1 (locked)

- **Platform:** native Android app built with Flutter (previously a PWA; pivoted since nothing was built yet and native Android is the priority; PC/browser access is secondary/deferred)
- **Stack:** Flutter + Dart (frontend) + Supabase (Auth + DB). Next.js/Tailwind/shadcn/PWA approach dropped for the app itself
- **Local/offline storage:** Drift (locked over Isar; relational fit with Supabase schema)
- **Distribution:** Play Store via native Flutter build, no TWA/PWA wrapper
- **Auth:** sign-up via school email + Student ID; login via Student ID or email + password
- **Timetable:** pre-loaded with exact Year 3 Mon–Fri schedule
- **Views:** Daily / Weekly / Monthly / Full Semester calendar
- **Attendance:** self-mark Present/Absent + notes, calculated per course, 75% threshold, ranking page
- **Exclusions:** non-class days, public holidays and exam period excluded from possible sessions
- **Events:** key academic events, editable (add/edit/remove)
- **Extras:** next-lecture countdown, push notifications, personal notes/to-dos per day, attendance report export (PDF + Excel), offline-first with sync queue, dark/light mode
- **Future-ready:** timetable/calendar data-driven so other users can eventually upload their own

## 2. Two modes

- **Mode 1 — Self-assessment:** everything in the individual student's control, no third-party monitoring (current build)
- **Mode 2 — Institutional:** school controls attendance, events and timetable; each lecturer controls attendance for their own class. Three account types: Student, Lecturer, Registry (full control)

---

## 3. Mode 1 (self-assessment) details

### Sign-up & onboarding
- Requires a working, verifiable email (not necessarily school-domain-locked) — needed for access, support/feedback and possible future subscription billing. Student ID field is just for the student's reference, not verified (no Registry in this mode)
- New (non-LIU) students building a timetable from scratch:
  - Primary path: AI upload & parse — upload timetable PDF/image, AI extracts courses/days/times/rooms/lecturers, student reviews and confirms/corrects before saving
  - Same AI-upload pattern for the academic calendar (key events)
  - Manual entry is both a fallback and the review/correction step
- Upload also accepts .md files directly (for students who already structured their timetable with their own AI tool)
- App provides in-app instructions + a copyable prompt template so students can use their own AI chat tool to produce the exact markdown format HoldCourse expects (one canonical format → parsing is validation, not fuzzy extraction)

### AI access & monetization
- No free built-in AI. Student must choose either:
  1. BYOK — their own AI API key
  2. Paid plan — HoldCourse-managed AI access
- BYOK key security: encrypted at rest, never plaintext; all AI calls server-side; key never sent back to browser; masked in UI; can be updated/removed anytime; validated with a real test call before saving

### Design principle
- Every feature, especially technical ones (BYOK setup, AI extraction, manual code entry, etc.), needs specific step-by-step in-app instructions

### Storage architecture
- Core app data (timetable, attendance, CAT scores, notes, etc.) always lives on ONE central HoldCourse-managed database for every user
- Only FILES (lecture materials, course outlines, assignment attachments, backups) use pluggable storage:
  1. Free — self-hosted database/bucket (e.g. free-tier Supabase, with in-app instructions)
  2. Free — student's own Google Drive (hidden appDataFolder)
  3. Paid — HoldCourse-managed file storage
- Explained to the user at sign-up
- Authentication always stays centralized through HoldCourse regardless of storage path
- Schema-migration risk for self-hosted users does not apply (they only hold blobs, not relational data) — resolved

### Attendance & CAT
- Self-mark attendance + notes per course, 75% threshold
- CAT tracking is personal/self-reported, no verification
  - Multiple entries per course (CAT1, CAT2, assignments…), each with its own weight and score
  - Default: CATs 40% / exam 60% of final grade — editable, but one global setting for all courses
- Target-grade calculator: set a target per course, app back-calculates the exam score needed

### Course Hub (per course unit)
- Course-specific next-lecture countdown
- AI-summarized overview from a student-uploaded course outline (editable after generation)
  - Re-uploading an outline regenerates the overview (no version history); warns first if the student manually edited it
- Lecture materials library
  - Auto-organized by semester week (from upload date vs. timetable) AND custom folders/categories (e.g. "Past Exams", "Slides")
- Assignment tracker: due date, priority, notes, file attachment for the submission; due-date push notifications
- Course-specific notes: multiple separate named notes per course (mini notes app), distinct from day-based notes/to-dos
- Consolidates that course's attendance % and CAT standing
- Search is per-course, with a toggle: titles/filenames only vs. full content (notes text and uploaded file contents)
- Removing a course from the timetable archives its hub content for 7 days, then permanently deletes
- Repeated course codes across semesters: content auto-carries over but stays labeled by originating semester ("This semester" vs "From [previous semester]")
- Also to be added to Mode 2 (to be refined later)

### Timetable editing (post-onboarding)
- Dedicated Edit Timetable flow: add/edit/remove courses and weekly slots, no approval needed
- Permanent change (updates recurring pattern) vs. one-off change (single date only)
- Edits affect future occurrences only; past recorded attendance unchanged

### Notifications
- Nine triggers: class reminders, assignment due dates, low attendance warning, CAT entry reminder, target grade unreachable alert, attendance streak nudge, to-do/task reminders, semester event reminders, daily morning summary
- Per-category on/off toggle plus custom timing where relevant (e.g. minutes before class)

### Offline & sync
- Works fully offline and syncs later: attendance marking + notes, cached timetable/calendar, CAT scores, notes/to-dos, assignment tracking, event edits
- Needs connectivity: login, file uploads, AI overview generation, push delivery
- Multi-device sync conflicts are flagged for the student to pick which version to keep (not last-write-wins)

### Export
- PDF export meant to look presentable for personal use and for showing a parent/sponsor/mentor
  - Header: name, Student ID, program, year, semester, generated date
  - Attendance summary per course (vs 75% threshold + overall average)
  - Academic/CAT standing per course (entries, running standing, exam score needed for target)
  - Overall snapshot summary
  - Personal notes/to-dos deliberately excluded
  - Filterable by date range
- Excel export also planned

### History, backup, deletion
- Semester switcher to view any past semester's full data (read-only/archived); no cross-semester trend view needed
- On semester end, data auto-saved as a labeled backup (e.g. "Semester Archive: Aug–Dec 2026"), distinct from manual backups
- Restore handles: (1) same-account recovery, (2) migration into a new account/device
  - Reads backup file from wherever file storage lives, shows preview/summary before committing, imports on confirmation
  - Same-account conflicts flagged for the student to choose (not full overwrite)
- Backup reminder notification, default weekly, configurable
- Account deletion: central app data, HoldCourse-managed storage deleted and subscription cancelled; files in the student's OWN storage (self-hosted DB, Google Drive) are left untouched. 30-day grace/recovery period before permanent

### Analytics dashboard (all four)
- Attendance trend over time (per course or overall)
- CAT score trend across entries
- Workload view (classes + assignments due, week by week)
- Cross-course comparison chart (visual version of the ranking list)

### Other
- Full accessibility pass: font scaling, high-contrast/colorblind-friendly mode, screen reader support, reduced motion
- In-app feedback/bug report: category selector (bug/feature request/general), description, optional screenshot, auto-includes device/app version info

---

## 4. Mode 2 (institutional) details

### Roles
- **Student:** own timetable derived from program/course/year enrollment (sees only their classes)
- **Lecturer:** manages own courses/sessions only — starts/ends class (triggers QR), views live + historical attendance for own courses, manual override for individual students, exports own course reports. Cannot touch other lecturers' courses, calendar, timetable structure or accounts. Cannot see other lecturers' schedules
- **Registry:** full control; sets pass threshold per institution (default 75%)

### Attendance marking
- Lecturer starts class → system generates a QR (also emailed as a link) for students to scan and self-mark
- QR auto-rotates every ~20–30 s to prevent screenshot-sharing/proxy marking
- QR expires 30 min after class ends
- Proximity check (student must be near the lecture room)
- Online-only — no offline mode for attendance marking. Offline scoped only to conflict-free features (notes/to-dos)
- Manual (camera-less) entry: rotating code shown as typeable text PLUS an auto-generated 3-digit lecturer session code disclosed verbally (never on-screen). Student enters both; substitutes for GPS proximity on camera-less devices
  - 1-minute limit to submit both codes; exceeding it flags the attempt as suspicious
- Proximity/GPS failure: student offered the manual code fallback; if unresolved, attempt goes to lecturer as "pending" for manual review (not auto-absent)
- Late session start: lecturer can start until 20 min before class ends
- Forgotten session end: auto-closes at class end + 30-min grace
- Device/access gap: lecturer can send a direct link to mark attendance
- True zero-device case: defaults to absent; corrected only via the standard dispute process once access is regained
- Server/connectivity outage: lecturer takes manual roll call and enters it after recovery, flagged as post-outage entry (not auto-cancelled)

### Session changes & recalculation
- Lecturer can freely cancel/reschedule their own single sessions without Registry approval (just notifies students)
- Cancelled sessions (no makeup) drop out of the denominator; rescheduled sessions still count under the new date/time
- University-wide disruptions: Registry manually marks each affected class "institution cancelled" (no auto bulk-detection)

### Disputes & authorization
- Student disputes go to the lecturer first; unresolved → Registry
- 36-hour dispute window after a session
- Registry cannot unilaterally edit a record — lecturer must also authorize (2-factor)
- Registry can view full audit logs of lecturer actions (dispute resolutions, student flags, record changes)
- Semester-end freeze: manually triggered by Registry; once frozen ALL attendance records are fully read-only, even to lecturers, no override. Disputes expected to be resolved before exams

### Lecturer tracking & lifecycle
- Lecturer attendance tracked quietly (sessions actually held), visible only to Registry, aggregated by year/semester
- Cancellations vs no-shows tracked as separate categories; Registry judges them (no auto-penalty)
- Guest/substitute flow: "Assign Guest Lecture" — regular lecturer triggers, Registry approves (2-key), guest logs in as lecturer for that session only; held-lecture count counts toward both records
- Fired/removed lecturer: Registry deactivates account directly (bypasses co-sign), system prompts Registry to assign a new lecturer; historical data preserved
- Lecturer accounts persist year-round; only course/session assignments refresh each semester

### Announcements & contact
- Class announcements reach students via in-app + push + email
- Lecturers always see a student's email; other contact info depends on the student's privacy preferences (set in a student/lecturer portfolio; Registry accounts need none)

### Accounts & enrollment
- Students and lecturers self-sign-up; Registry must approve each account before activation
- Sign-up form collects program, course, year of study
- Registry can pre-upload a student roster (details + courses); sign-ups auto-matched/authenticated; unmatched fall back to manual review
- Student accounts deactivate at the end of each semester (when Registry locks it); portfolio and prior data stay accessible in a history tab; each new semester students sign in fresh and are re-checked against the updated roster (auto-match or manual approval). Repeat/held-back students handled by the roster, no separate promotion logic
- Mid-semester course transfers: tracking starts from enrollment date; earlier sessions don't count against them
- Graduated/withdrawn students: full record kept permanently, account archived (not deleted)

### Scaling & infrastructure
- Each institution's data fully isolated — no cross-institution visibility, no super-admin above Registry
- BYO-database architecture wanted: each institution connects HoldCourse to its own server/database for client-side data control
- Timetable room/time conflicts are a hard block (cannot save two courses in the same room + time slot)

### CAT scores (Mode 2)
- Same role pattern as attendance: lecturer enters, Registry moderates
- Students can dispute up to 48 h before the CAT score delivery deadline (set by Registry)
- Lecturers must submit scores for all students at least 1 week before that deadline (can still add scores any time before it)
- Compliance gate: per-course scope only; never blocks time-critical actions (live sessions, attendance marking, active disputes); blocks other course-specific screens until scores complete; shows "X of Y scored" progress; lecturer can mark a student "pending — [reason]"; unresolved gate past the real deadline shows on Registry's audit/compliance view

---

## 5. Build status (as of last handoff, pre-October restart)

**Built**
- Onboarding (10 screens)
- Dashboard
- Course Hub shell + Overview + Materials tabs (not yet compiled to files)
- Attendance Screens 13–16 (fully built and approved)

**Known pending fixes**
- Screen 14 wiring: use Screen 15 as a proper widget
- Screen 16: hardcoded color must read from the theme

**Not yet implemented**
- Course Hub: Assignments and Notes tabs
- CAT tracking
- Analytics (not even wireframed)
- Backup/Restore
- Export
- Settings

**Quick Check-in:** spec written + Flutter `check_in` folder written (uncompiled). See QUICK_CHECKIN_SPEC.md.

### flutter_lucide icon naming (fixed)
- Real convention is snake_case (kebab-case name with `-` replaced by `_`), NOT camelCase
- Upstream renames: check-square → square-check, check-circle → circle-check, home → house, more-horizontal → ellipsis, bar-chart-3 → chart-bar, wand-2 → wand, trash-2 → trash
- Bare `grid` doesn't exist; mapped to `grid-3x3`

---

## 6. Dev team & workflow

- AI agents installed (all free tier): ChatGPT, Claude, Copilot, DeepSeek, Gemini, Grok, HugFace App, Kimi, MiniMax, Perplexity
- Roles: DeepSeek (lead architect/logic), Claude (code architect / project manager / integrator-reviewer), Kimi (Flutter UI/widgets), Gemini (UX/screenshots), Perplexity (research), ChatGPT (second opinion/debug), Copilot/MiniMax/HugFace (overflow), Grok not used
- Workflow: state-doc + per-phase prompt, with Claude as integrator/reviewer between handoffs
- Kimi repeatedly hit usage limits and lost memory between sessions; MiniMax works well as overflow when given actual canonical source files, not just the wireframe spec
- **Oct 2026:** restarted development with CLI coding agents (Claude Code / Grok CLI / Codex), an AGENTS.md-based starter repo, and a separate graphics asset list. Kimi/MiniMax limits were the reason for the restart
