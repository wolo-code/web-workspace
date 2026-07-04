# Agent Instructions

- When modifying or adding application behavior, UI, or user-facing flows, update `APP_FEATURES.md` and `APP_SECTIONS.md` in the same change so the app documentation stays current.
- Keep commits atomic: each commit should contain one coherent behavior or documentation change, and unrelated files should be committed separately.
- At the end of complete change - provide appropriate commit message that can be used to save to scm, beneath initial line add detailed commit change.
- Update the docs/APP_FEATURES doc when applicable
- Do not edit files in `public/` and `interim/` for source changes; they are generated/rebuilt before deployment.
- At the end of a completed change, include a concise suggested git commit message that can be used for committing the work.

## Repository structure

This is the `wolo.codes` monorepo — an aggregator of several independently-versioned repos, each checked out under its own path (some are git submodules):

| Path | Upstream repo | Role |
| --- | --- | --- |
| `project/` | wolo-code/web | Aggregator + local Nginx reverse proxy (docker, `project/nginx`). |
| `project/build/` | (build output) | Firebase Hosting project dir. `firebase.json` owns production routing; serves the merged `public/`. |
| `app/project/` | wolo-code/web-app | The web app (Firebase-hosted PHP/JS: map, encode/decode; Cloud Functions in `app/project/functions`). Owns `/` in the merged site. See `app/project/docs/PROJECT_ARCHITECTURE.md`. |
| `site/project/` | wolo-code/web-site | The marketing/content website, built on the **Cutie** framework (`site/project/root/Framework`, a submodule). Owns content pages (`/about`, `/features`, …). |
| `tiggu/` | blank-org/tiggu | Build/render toolchain (`Render → Build → Publish → API`); outputs `interim/` + `public/`. |
| `firebase/` | blank-org/firebase | Dockerized Firebase CLI for deploy / CI setup. |

## Merged site & the empty root

In production, **app + site are merged into one Firebase Hosting deploy** (`project/build`). There the **app** serves `/` (root); the **site** serves its content components under their own paths. The site's own root component (`site/project/root/HTML/Component/Root.html`) is an **intentionally empty placeholder** — locally, `/` is deliberately 404'd by `site/project/root/.htaccess` (`RewriteRule ^$ - [R=404]`). Do not "fix" that blank page or that rule; it is by design.

## Site framework (Cutie)

- PHP server-rendered, component-based. Components are declared in `site/project/config/ID.tsv` (columns: `Status, Id, Label, Title, JS, Description, Flags`). Page assembly flows `root/Framework/HTML/Page.php` → `root/HTML/Template/Base.php` → per-component `root/HTML/Component/*`.
- Client navigation is an AJAX SPA: anchors with class **`XURL`** are intercepted (`root/Framework/JS/XURL.js` → `loadCanvasI` in `Canvas.js`) to fetch `/<id>.json` (`Framework/HTML/Component.php`) and swap `#content` in place instead of doing a full page load. Plain **`content-link`** anchors (no `XURL`) navigate normally. To make a link do a real navigation, omit `XURL`.
- Local serving is Apache + PHP via `site/project/Dockerfile` + `httpd-vhosts.conf` (vhosts for root/interim/public). `.htaccess` handles routing/rewrites **for local only**; production routing lives in `project/build/firebase.json`.

## Generated directories — never edit for source changes

`public/` and `interim/` (in every project) are Tiggu build output. Edit the source (`root/`, `config/`, `HTML/`, etc.) and rebuild; the note above about `public/` and `interim/` applies repo-wide.
