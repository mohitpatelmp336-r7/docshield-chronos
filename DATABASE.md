# Database — DocShield Chronos

**Database: PostgreSQL, via Supabase (Supabase Auth + Postgres + Row Level Security).**

This is not a new choice — the project already shipped with a complete
Postgres schema for Supabase at
`drizzle/migrations/0000_docshield_core_schema.sql` (tables: `profiles`,
`user_roles`, `cases`, `devices`, `sanitization_operations`,
`recovery_operations`, `audit_logs`, `erasure_receipts`, all with Row Level
Security policies) and a typed Supabase client at
`src/integrations/supabase/`. What was missing was the wiring between the UI
and that schema — the app was reading fake, in-memory data. This pass adds
that wiring:

## What's now real (backed by actual Postgres rows)
- **Sign up / sign in / sign out** — real Supabase Auth (`src/lib/auth.tsx`).
  A new signup creates a row in `auth.users`, and a database trigger
  (already in the migration) auto-creates the matching `profiles` and
  `user_roles` rows.
- **Role selection** — writing the chosen role persists to `user_roles`.
- **Devices, sanitization jobs, recovery scans, audit log, erasure receipts**
  — `src/lib/forensics/supabase-adapter.ts` implements the same
  `ForensicsApi` contract the UI already used, backed by the real tables
  instead of the in-memory mock. Nothing in the route files (dashboard,
  sanitization, recovery, erasure, etc.) had to change — that seam
  (`src/lib/forensics/client.ts`) was already designed for exactly this
  swap.
- The app **automatically uses the real adapter** once `VITE_SUPABASE_URL`
  and `VITE_SUPABASE_PUBLISHABLE_KEY` are set, and falls back to the mock
  adapter if they're not — so it never hard-crashes with no `.env`.

## What's still intentionally simulated
- Individual recoverable-file listings and forensic-artifact acquisition
  records — the schema (correctly) has no table for these, because a
  browser app cannot really enumerate deleted sectors on a physical disk
  without an OS-level agent. Faking that at the database layer would be
  dishonest, so it stays as clearly-labelled simulated output, same as
  before.
- The MFA / device / AI-risk verification gate — no real government
  identity provider is connected. Each pass is still logged as a real row
  in `audit_logs`.

## How to connect your own Supabase project
I can't create a Supabase project or reach supabase.com for you from this
environment — you'll need to do this part yourself (free tier is enough):

1. Create a project at supabase.com.
2. In the Supabase dashboard → SQL Editor, paste and run the contents of
   `drizzle/migrations/0000_docshield_core_schema.sql`.
3. In Project Settings → API, copy the **Project URL** and the
   **anon/publishable key**.
4. Copy `.env.example` to `.env` and fill in:
   ```
   VITE_SUPABASE_URL=your-project-url
   VITE_SUPABASE_PUBLISHABLE_KEY=your-anon-key
   VITE_SUPABASE_PROJECT_ID=your-project-id
   ```
5. `npm install && npm run dev`.

Once `.env` is filled in, registering an account in the app creates a real
row in your Supabase project's `auth.users` table — check the Supabase
Table Editor after signing up to see it for yourself.

## What I verified in this sandbox
I don't have network access to Supabase's cloud from here, so I couldn't
test against your actual project. Instead I:
- Ran `npx tsc --noEmit` and `npm run build` on the full project — both
  pass clean.
- Installed a local PostgreSQL instance and ran the exact migration SQL
  above against it, then exercised the real signup trigger and the exact
  insert statements the new adapter code issues (device → sanitization job
  → audit log) — all succeeded and produced the expected rows.
