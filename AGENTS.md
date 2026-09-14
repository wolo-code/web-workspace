# Agent Instructions

- When modifying or adding application behavior, UI, or user-facing flows, update `APP_FEATURES.md` and `APP_SECTIONS.md` in the same change so the app documentation stays current.
- Keep commits atomic: each commit should contain one coherent behavior or documentation change, and unrelated files should be committed separately.
- When a coherent piece of work is complete, **commit it immediately** in every affected nested repo (`app/project`, `site/project`, `site/project/root/Framework`, aggregator `D:\Wolo\Web`, and others only if they actually changed). Do not wait for the user to ask, and do not only suggest a message. First line is the summary; following lines explain why. Do not push unless asked. Skip `public/`, `interim/`, `.playwright-cli/`, and secrets.
- Update the docs/APP_FEATURES doc when applicable
- Do not edit files in `public/` and `interim/` for source changes; they are generated/rebuilt before deployment.

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
| `console/` | wolo-code/console | Local OliveTin GUI to bake the merged site and deploy to `dev.wolo.codes` or `wolo.codes`. |

## Merged site & the empty root

In production, **app + site are merged into one Firebase Hosting deploy** (`project/build`). There the **app** serves `/` (root); the **site** serves its content components under their own paths. The site's own root component (`site/project/root/HTML/Component/Root.html`) is an **intentionally empty placeholder**. Locally, Caddy sends `/` to the **app** on :8085; the site on :8084 serves `/about` and other content paths. Unknown paths 404 on the site then fall back to the app (wolo codes). Do not flatten `/` onto the PHP site homepage.

## Site framework (Cutie)

- PHP server-rendered, component-based. Components are declared in `site/project/config/ID.tsv` (columns: `Status, Id, Label, Title, JS, Description, Flags`). Page assembly flows `root/Framework/HTML/Page.php` → `root/HTML/Template/Base.php` → per-component `root/HTML/Component/*`.
- Client navigation is an AJAX SPA: anchors with class **`XURL`** are intercepted (`root/Framework/JS/XURL.js` → `loadCanvasI` in `Canvas.js`) to fetch `/<id>.json` (`Framework/HTML/Component.php`) and swap `#content` in place instead of doing a full page load. Plain **`content-link`** anchors (no `XURL`) navigate normally. To make a link do a real navigation, omit `XURL`.
- Local preview is Apache + Caddy at https://wolo.local/ (not Docker compose-dev). `.htaccess` is for the PHP site on :8084 only; production routing lives in `project/build/firebase.json`.

## Generated directories — never edit for source changes

`public/` and `interim/` (in every project) are Tiggu build output. Edit the source (`root/`, `config/`, `HTML/`, etc.) and rebuild; the note above about `public/` and `interim/` applies repo-wide.

## Local Windows hosting (D:\Wolo\Web)

Local preview is Apache + Caddy at **https://wolo.local/**, not Docker `compose-dev`.

- `/` is the encoder app (`D:\Wolo\Web\app\project\root`, Apache :8085).
- `/about` (and faq, features, downloads, …) is the Cutie site (`D:\Wolo\Web\site\project\root`, Apache :8084).
- Shared stack, vhosts, Caddy, hosts, and prove commands: see this file and `DOCKER.md`.
- Header: theme menu (light/dark/system). No header download button; Downloads stays in the footer and menu.
- Site Framework is a submodule (`blank-org/cutie-framework`). Do not commit site-only CSS there.
- Do not edit `public/` or `interim/` for source changes; they are Tiggu/generated. Production publish is `wolo-code/web-public` (`D:\Wolo\Web\project\build`); Firebase Hosting deploys on push to `main`.
- Site source repo: `D:\Wolo\Web\site\project` → `wolo-code/web-site`.
- Operator console: `https://console.wolo.local/` (OliveTin on `127.0.0.1:47822`). Start with `D:\Wolo\Web\console\Start-Console.ps1`. **Deploy to development** uses the Firebase CLI against project `waddress-5f30b` (`https://dev.wolo.codes`) and then purges Cloudflare for that origin. **Deploy to production** pushes `web-public` `main` (`https://wolo.codes`); Hosting CI purges the whole `wolo.codes` Cloudflare zone. Hosts: `127.0.0.1 console.wolo.local`. Reload Caddy after `C:\programs\Caddy\caddyfile` changes.

## Native Tiggu publish (Dockerless — preferred)

Site/app HTML bakes and the production merge should use the native Windows pipeline — **not** Docker by default.

1. **Once:** run `project\Install-NativePublishTools.ps1` (downloads pinned minify + Closure Compiler into `D:\Wolo\Web\.native-tools`). Needs Java (Android Studio JBR) and `python` on PATH.
2. **Bake one project:** `. .\project\PublishRunner.ps1; Invoke-WoloNativeTiggu -Kind site` (or `-Kind app`). Origin/Host: site → `http://127.0.0.1:8084` + `wolo.local`; app → `:8085` + `wolo.local`.
3. **Full merge:** `.\project\render-native.ps1` (same order as `render.sh`: increment app `build` in `app/project/Root/Config/Vars.tsv`, tiggu app, tiggu site, copy site then app into `project/build` so app overwrites). Does not replace `firebase.json`. Native bake and Firebase Hosting CI run `project/build/scripts/verify-sri.mjs` so stale `integrity` hashes (Sentry CDN) fail before deploy. Pass `-SkipBuildIncrement` (or `TIGGU_SKIP_BUILD_INCREMENT=1` for `render.sh`) to bake without bumping the Info dialog build number.
4. Apache + Host `wolo.local` on :8084/:8085 must respond before bake (runner probes). Docker `compose-dev` remains an optional fallback only.

## Resource → URL list

**Resource → URL list:** When you add a file under `site/project/root/Resource/` that must appear in production (covers, logos, static images), also add a matching row to the site’s bake URL list (`config/Url.tsv` / `URL.tsv`, and `Url_<lang>.tsv` when language-specific). Empty Path + Name + Extension → public `/{name}.{ext}` (usual for covers like `faq.svg`). Path `resource/` → public `/resource/{name}.{ext}`. Live PHP may work from Resource alone; baked Firebase/`web-public` only gets assets Tiggu fetches from that list. Do not hand-edit `interim/`/`public/`/`web-public` for new assets—update Resource + Url list, then bake and publish.

## Image proportion / credits
Site config/Image_display.tsv overrides tile/hero fit. FAQ uses hero+cover. Base.php must call `renderComponentBody()`. See web-site AGENTS.


## Encoder publish caveat
When publishing the app/encoder bake into `web-public`, copy the full app `public/` outputs needed by `index.html` — especially hashed `root-*.min.js` (+ `.map`) — not only `index.html`. Firebase `**` rewrite falls back to `index.html` for missing paths, which surfaces as `Unexpected token '<'` in the browser.
