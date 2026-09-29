# DocShield Chronos — Public Deployment

This build is prepared for a single public web service. The frontend uses the same origin for `/api`, so no localhost API URL is required in production. The Node backend serves the Vite `dist` output and binds to `0.0.0.0`.

## Render
1. Push this folder to a GitHub repository.
2. In Render, choose **New + → Blueprint** and select the repository.
3. Render will read `render.yaml`.
4. Set `DOCSHIELD_DEMO_PASSWORD` when prompted (or keep the documented demo password for a demo instance).
5. Deploy. The public URL will be `https://<service-name>.onrender.com`.

The included persistent disk keeps SQLite data and uploaded evidence across deploys/restarts. The persistent disk is a paid Render resource; without persistent storage, uploaded files and SQLite data should be treated as temporary.

## Local production check
```bash
npm install
npm run build
node backend/server.mjs
```
Then open `http://localhost:4000`.

## Important
The app remains a simulation/demo for privileged physical-drive sanitization and raw-sector forensic acquisition. It does not claim real hardware erasure.
