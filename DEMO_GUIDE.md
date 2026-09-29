# DocShield Chronos — Local Demo Guide

This build is designed so the main product flow can be demonstrated without a Supabase project.

## Start

### Windows
Double-click `START_DOCSHIELD.bat`.

### Terminal
```powershell
npm ci
npm run start
```

Open `http://127.0.0.1:5173/`.

## Walkthrough

1. **Landing** — open the console.
2. **Login** — use any email, a password with 6+ characters, and any 6-digit MFA code.
3. **Verification** — the demo advances through the verification checks automatically.
4. **Role Selection** — choose Investigator or Administrator.
5. **Command Center** — review the sample devices, activity and storage data.
6. **Recovery** — run the scan steps and inspect sample recoverable artifacts.
7. **Sanitization** — choose a sample device and move through the verification workflow.
8. **Reports** — review the sample report records.

## What is real in this local build?

The UI, navigation, validation, workflow state, progress indicators, sample data, hash display and report views are functional. The local forensics adapter stores demo state in memory.

The browser does **not** access raw disks, recover deleted files from physical drives, or erase hardware. Those operations require a privileged backend/agent. The interface labels the local adapter as simulation/demo data rather than claiming those operations occurred.

## Supabase mode

Set the Supabase environment variables from `.env.example` to switch the authentication/data seams to the configured backend. No service-role secret belongs in frontend environment variables.
