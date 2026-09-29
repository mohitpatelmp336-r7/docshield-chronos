# DocShield Chronos

A professional cybersecurity and digital-forensics web application for document/data sanitization workflows, recovery analysis, verification, and audit reporting.

> **Safety note:** this application uses safe/mock workflows for operations that would require operating-system-level disk access. It must not claim that a file was securely erased unless a real backend operation has actually performed and verified the operation.

## Features

- Security-focused dashboard
- Secure data erasure workflow UI
- File recovery analysis workflow UI
- Forensic analysis workspace
- Reports and audit-oriented views
- Settings and configuration UI
- Responsive React + TypeScript interface
- Reusable UI components
- Supabase-ready configuration

## Tech Stack

- React 19
- TypeScript
- Vite
- TanStack Router / Start
- Tailwind CSS
- Supabase client
- Drizzle ORM
- Recharts
- Radix UI

## Local Setup

### Requirements

- Node.js 22.16+
- npm

### Install

```bash
npm install
```

Copy `.env.example` to `.env` and add your own Supabase project values if you want to enable the configured backend integration.

### Run locally

```bash
npm run dev
```

### Production build

```bash
npm run build
npm run preview
```

### Code quality

```bash
npm run lint
npm run format
```

## Environment Variables

Never commit `.env` or private credentials. Use `.env.example` as the template.

```text
VITE_SUPABASE_URL=
VITE_SUPABASE_PUBLISHABLE_KEY=
VITE_SUPABASE_PROJECT_ID=
```

## Deployment

The project can be deployed to a Vite-compatible hosting provider such as Vercel, Netlify, or Cloudflare Pages. Configure the required environment variables in the hosting provider before deployment.

## Project Structure

```text
src/
  components/       Reusable application and UI components
  hooks/            React hooks
  lib/              Client utilities
  routes/           Application routes
public/             Static assets
drizzle/            Database schema and migrations
```

## Security

Do not commit passwords, service-role keys, access tokens, or other secrets. Public client-side Supabase publishable keys are not a substitute for server-side authorization and database security policies.

## Original Prototype

The initial UI prototype was created with Lovable. This repository is intended to be maintained and developed independently through the source code.


## Full-stack local mode

The project now runs as a single full-stack development command. `npm run dev` starts both the Vite frontend and the Node API. The local API uses Node's built-in SQLite support, so no PostgreSQL installation is required for the local environment.

### Run

```bash
npm install
npm run dev
```

Open `http://localhost:8080/`. The API listens on `http://127.0.0.1:4000/`.

### Persistent backend

- SQLite database: `data/docshield.sqlite`
- Seed source: `data/db.json` (used on first database initialization)
- Uploaded files: `data/uploads/`
- Auth: password-hashed users + expiring bearer sessions
- API: authenticated dashboard, devices, jobs, scans, reports, activity and file intake endpoints
- File intake: raw HTTP upload to disk with SHA-256 hashing; 50 MB local limit

### Demo account

- Email: `demo@docshield.local`
- Password: `Demo@12345`
- MFA: any 6 digits for the prototype verification gate

### Important production boundary

The web application is fully wired end-to-end for document/file workflows, metadata, audit records and persistent local storage. Actual secure disk erasure and low-level deleted-file recovery require a privileged native/agent service with operating-system/device access; the current workflows deliberately remain safe simulations and do not claim real erasure or forensic recovery.

Supabase integration remains available as an optional production backend path.
