
## Web App Features

### 1. Primary Map Experience

- Full-screen Google Maps UI, with optional OpenStreetMap, Apple Maps, Esri, and Microsoft Maps tiles.
- Default map opens globally at a zoom that fills the viewport height (no blank bands at the top or bottom), then moves to a detected or selected city/location. Switching from Wolo Code Input View waits for the Google map object before calling `setMapTypeId`, so an early tap does not throw.
- Supports terrain/map, Google Satellite view, OSM, Apple Maps, Esri, and Microsoft Maps modes.
- On OSM, locating or opening a saved address caps at street zoom (about 19) without a toast. **Map data not yet available** appears only when OSM tiles 404 at the current zoom and the camera steps back.
- Profile menus (account and login) let you enable or disable Google Maps, OSM, Apple Maps, Esri, and Microsoft Maps, and set one enabled source as default. The default inbound arrow sits before the enable toggle. Only the active default inbound arrow stays visible; an inactive inbound arrow appears when that map source row is hovered or focused. Extra padding sits below the last map source row. The default map source label uses the primary accent. Appearance theme tiles have extra space between them. Theme icons stay large until hover or focus, then shrink so System/Light/Dark labels can appear. The selected theme keeps its label visible in the primary accent. Light-mode theme icons stay gray instead of using the primary accent; dark-mode hover uses a gray highlight. Section headings use the muted dialog label color, not the primary accent.
- Includes floating controls for account, location, info (Wolo Code Input View and map views, before Wolo Code input on the map), Wolo Code input (map views), map-type switcher in the bottom-right corner (map views), notifications, and footer links. Those icon controls show native hover tooltips except the appearance theme buttons. The first two launches show icon captions on the Wolo Code Input View background, not the map (light mode keeps that background; dark mode adds an 80% dark overlay), and only after the user proceeds on the first-run intro modal; a tap anywhere or a 4-second timeout from `Vars.tsv` `icon_guide_timeout` fades it away. The Info modal's bottom-left **show guide** button closes the modal and shows that overlay again on the current view, including map views; hover does not underline the button. Map View captions include Previous, Search, Go, and D-pad, plus a sample Location Wolo Label View (`Wolo-infocard-sample.svg`) with larger callout titles, italic short descriptions, and leader lines that end in circle dots on City, Wolo Code, Address, Open, and Label; a tap on the map or the 4-second timeout from `Vars.tsv` fades that overlay without freezing the tab. Map View guide uses a `World-map.svg` backdrop on the input-view fill (teal land in light mode, brand-accent land in dark mode) instead of a blank wash. OSM still uses that input-view fill rather than an 80% dark overlay. Wolo Code sits to the right of its icon and D-pad to the left of the camera control. The search bar, Go button, and camera control stay above the dimmer. Search and Go are lifted above the page scrim so they stay readable as solid themed fields, without an extra accent ring. The centered caption cluster stays vertically middle and can shift up on very small screens so bottom notifications stay visible. The map camera dpad sits on the same vertical band as Locate, matching the 39px map-type disc with a small gap to its left. Locate from Wolo Code Input View switches to the default map view and starts geolocation. The Wolo Code Input View map button always uses the terrain SVG, regardless of which map source that control will open.
- Google’s logo and map-data credit stay on Google terrain/satellite only; OSM, Apple Maps, Esri, and Microsoft views hide that branding. Non-Google OSM/Esri/Microsoft attribution sits bottom-left after a small gap from the bottom-left chrome, close to the bottom edge, and stays on one line on widescreen. Apple Maps shows MapKit’s logo without a blur overlay or an extra Apple text label.
- Apple Maps follows the Google overlay during drag with a CSS transform and only recommits MapKit’s camera on idle, zoom, or a large pan.
- Location Wolo Label View (map InfoWindow) uses a dark card and high-contrast Wolo Code text in dark mode.
- Address Panel follows light/dark theme, shows plus code in India as well as DIGIPIN with labels on the left and code values on the right, copies DIGIPIN in uppercase, copies drag-selected text without replacing the highlight, stays open after navigating with a DIGIPIN or plus code, and hides when Locate starts. Small QR icons sit after the street address (bottom-right) and after each DIGIPIN and plus code (to the right) and open a modal with that value as a QR code. Opening a saved address keeps the decoded latitude (the bottom panel no longer shifts the camera north). Saved title is the parent line and segment is indented beneath it, matching the account list. Bottom toasts and the accuracy strip stack above the Address Panel in a shared flex dock so they do not overlap when the panel grows.
- Supports URL/query-driven startup:
  - Path-based Wolo Code decode links.
  - `_` suffix for satellite map startup.
  - `?q=lat,lng` startup for external geo intents.
- Shows loader, top/bottom notifications, and recoverable error dialogs.

### 2. Encode - Map Location to Wolo Code

- User can switch to map mode and choose a location on the map.
- User can use current GPS location to encode the current position.
- User can search for a place and encode that selected location. In Map View the search field stays focused so typing can start without clicking it first.
- Reverse geocoding extracts the city-level Google Place ID.
- Firebase Realtime Database resolves city metadata and city center.
- Wolo algorithm encodes the selected coordinate into three 10-bit word indexes.
- Word indexes are mapped to the 1,024-word Wolo word list.
- App shows the generated Wolo Code with its city context.
- Locations outside a city's encode coverage (about 32.8 km from the city center) show **Area not covered** instead of repeating the same invalid code.

### 3. Decode - Wolo Code to Map Location

- User can enter a Wolo Code address in the format `City Word 1 Word 2 Word 3`.
- City can be omitted when the current city context is known.
- Last three tokens are treated as the code words.
- Preceding tokens are treated as the city.
- Web app resolves ambiguous city names through a "Choose the city" dialog.
- Unrecognized input opens a padded dialog that centers the typed value and offers matching primary-accent Edit code and Search map buttons (reverse-play and play icons). Search map opens Map View and the Address Panel.
- Decoded location is shown on the map and can be used for downstream map/navigation actions.

### 4. City Context and City Selection

- Detects city by IP via `POST https://wolo.codes/api/cityByIp`.
- Can detect city from current geolocation.
- Maintains a current city context.
- Provides "Choose the city" flow when multiple cities match.
- Shows nearby cities when selecting city context.
- Shows a current city label in city selection UI.
- Previous-city list stores cities from decode/encode and geolocation selection. Long-press a city to remove it from that list. Map views show that list control flush to the left of Place Search Input, outside the search field, with 5px rounded corners. Choosing a city on Map View zooms out to the viewport-fill overview first when already zoomed in, then pans to the city center and animates zoom-in to city-scope coverage.
- Falls back to manual map selection when location access is denied.

### 5. Location Permission and Accuracy Flow

- Presents a location-access prompt before requesting geolocation.
- Stores location permission preference and "do not ask again" state in local storage.
- Uses browser geolocation watch for high-accuracy location.
- Shows accuracy in meters.
- Shows an accuracy indicator whose color changes with accuracy. The strip is a fixed-height pill: the FF proceed control sits flush on the same layer, is vertically centered, and the width and item positions stay put across meter values and after proceed hides the control.
- Provides a "Proceed" control so users can accept the current fix before the watch completes. The top bar loader shows until the first GPS fix; then it hides so the zoom-in animation is the progress cue. Locate zooms to that first accuracy circle once and does not add a zoom-out/zoom-in snap at the end. While accuracy stays at `99+`, locate counts one sample per second even if the browser does not emit new GPS events, and auto-proceeds after five consecutive samples, unless locate is in long-press override (the locate icon stays blinking and auto-proceed is skipped).
- Handles permission denied, unsupported browser geolocation, invalid `0,0` positions, timeout, and low-accuracy states.

### 6. Unsupported City Request

- When a selected location is not in the supported city database, the web app prompts the user to add the city. The Add city dialog follows light and dark theme, including the wait spinner.
- User can confirm or decline the add-city request.
- While waiting for backend processing, the app explains that manual intervention may take hours.
- User can continue waiting or stop.
- Backend endpoint referenced in existing iOS planning: `POST /api/add-city`.

### 7. Place Search

- The web app includes Google Maps Places support.
- User can search for a particular place.
- Search result can become the active map position and be encoded.

### 8. Account, Login, and Saved Addresses

- Supports Firebase Authentication via FirebaseUI.
- Shows login/sign-up dialog.
- Shows account dialog with display name, email, profile photo, appearance, and map source prefs.
- Allows logout from an icon to the right of the name and email; the icon appears when hovering or focusing the profile photo, name, and email block (always visible on touch).
- Shows saved address list with loading, empty, and end states. The list starts collapsed. Caret then plus sit on the right of the Saved heading; caret expands or collapses the list, and plus expands the add-current-address form. Clicking Saved or the empty space up to the caret also toggles the list. Expanding the list folds Appearance and Map source above it, keeping the profile picture row. The profile, Saved heading, and add form stay put; only the address list scrolls. The list parks its scrollbar in the tile inset, with matching space on the left, so address tiles stay centered and keep the same width when the bar appears, and the scrollbar uses theme colors in light and dark mode. The dialog keeps a fixed width so expanding a saved address does not change it. Expanding a saved row animates the Wolo Code, street address, and actions open, and the dialog height grows with them. The Wolo Code is the first expanded block in the map-label format (`\ city` then `word-1 word-2 word-3 /`). The street address follows in the same Roboto, left-aligned gray treatment as the map Address Panel. Saved tiles are rounded on all corners. The title is the parent line; a segment is indented beneath it as the child, with padding below. A three-dot menu on the top right of each saved address holds Edit and Delete; on hover-capable pointers it appears only on tile hover, keyboard focus, or while the menu is open. In dark mode it uses the primary background with white dots. Edit opens the add form with that address's title, segment, and street text. Title and Segment fields hint with `e.g. Home` and `e.g. Main gate`, and the title, segment, and address fields share the same left inset as the tiles. Cancel sits on the left of the save section and Save stays on the right. Saving requires a located or decoded Wolo Code, except when updating an existing saved address. Go on a saved address stays on the right and opens it on the map at the decoded location, with the Address Panel showing that title and an indented segment.
- Save current address from QR Label View (title, segment, address, and a top-left address-book save icon). Title and Segment fields hint with `e.g. Home` and `e.g. Main gate`. Preview uses an eye-only icon. Clicking the dimmed overlay outside the dialog closes it. A successful save shows **Address saved** above the overlay. Refreshing the address book does not replace that with a city-lookup error. Saved rows show the Wolo Code as `\ city` on the first line and `word-1 word-2 word-3 /` on the second.
- Saved addresses can preserve Wolo Code plus user-entered metadata/address text.

### 9. Code Presentation, Sharing, and QR/Print

- Web app has a printable/shareable Wolo Code layout.
- Includes title, segment, Wolo Code, editable address, and `www.wolo.codes`.
- Supports QR preview.
- Supports download.
- Supports print.
- Supports saving the current Wolo Code address from a top-left address-book icon in the label dialog.
- Uses `html2canvas` and `jspdf` for export-oriented rendering.

### 10. External Navigation / Maps Redirect

- Shows "Redirecting to maps app" flow.
- Supports canceling the redirect.
- Android wrapper forwards geo intents to `https://wolo.codes/?q=...`.
- Decoded or selected coordinates can be handed off to a maps app.

### 11. Informational and Legal UI

- Intro explains the Wolo Code address format. The Info modal is vertically centered; dark mode drops the light outline around the brand lockup. On narrow viewports the full-screen overlay uses the dark dialog background in dark mode, and the first-run intro keeps a small gap between the author credit and the version number. A **show guide** button in the bottom-left corner hides the modal and shows the icon caption overlay on the current view (Wolo Code Input View or Map View). Hover does not underline that button. The bottom-right label shows `v` plus the three-part `version` from `Vars.tsv` on the same bottom line as **show guide**. Hover or keyboard focus expands the label to `version.build` and shows elapsed time since the bake under the version. Hovering that stamp shows the UTC timestamp. A tap keeps the full version visible and shows local time under the version; hovering that local stamp shows UTC. Times overlay below that line so the version stays put. The credits/links view includes crawl-proof `support@wolo.codes` and linked map credits (OpenStreetMap, Esri, Microsoft, Apple Maps, Google Maps). That view does not show **show guide**, a version number, or an updated timestamp.
- Shows sample input such as `Bengaluru cat apple tomato`. Choosing **Try: Bengaluru, India** pans to that sample and animates zoom-in to street level.
- Links to:
  - About
  - Terms of use
  - Privacy policy
  - Credits (`/credits`: location codes, maps, browser, and icons)
  - Source code
  - App download page
  - Contact email (`support@wolo.codes`)
  - Social pages
- Shows cookie/privacy notice.
- Shows unsupported browser warning.
- Shows a blocking unexpected error dialog titled `Oops an error occured!` with a warning icon, Clear cache & reload, and a crawl-proof support email on the next line after “You may contact our support team.” There is no close button. Press and hold the title to show the crash message and Continue. Clicking the dimmed overlay does not close it. Other overlay dialogs close when the overlay is clicked.
- Reports exceptions to Sentry. Hosting deploy and native bake refuse HTML whose `integrity` hashes do not match the current CDN bytes.
- Uses Firebase Analytics, Firebase Performance, and Cloudflare analytics. Production Hosting deploys purge the `wolo.codes` Cloudflare zone; development deploys purge `https://dev.wolo.codes` so stale HTML cannot linger on covers and JSON.

### 12. Backend and Third-Party Services

| Service | Purpose |
|---|---|
| Google Maps JavaScript API | Web map rendering |
| Google Maps Places | Place search |
| Google Geocoding | City/place resolution for coordinates |
| Firebase Realtime Database | City metadata, city centers, word list, saved data |
| Firebase Auth / FirebaseUI | Login and account management |
| Firebase Analytics | Usage events |
| Firebase Performance | Performance telemetry |
| Sentry | Error reporting (CDN SRI verified before/after deploy) |
| Cloudflare | CDN in front of Firebase Hosting (zone purge after production deploy; origin purge after development deploy); analytics |
| GeoFire | Encoded city center/location storage |
| html2canvas / jsPDF | Printable/downloadable code artifacts |

Core backend resources already used or planned by the iOS app:

| Resource | URL |
|---|---|
| Firebase RTDB production | `https://wolo-codes.firebaseio.com` |
| Firebase RTDB development | `https://waddress-5f30b.firebaseio.com` |
| cityByIp production | `https://wolo.codes/api/cityByIp` |
| cityByIp development | `https://dev.wolo.codes/api/cityByIp` |
| Google Geocoding | `https://maps.googleapis.com/maps/api/geocode/json` |

### 13. Site chrome (Cutie)

- Header theme menu (light / dark / system). Downloads live in the site menu, not the header. The footer has store badges and wolo.codes/get, not a download icon.
- Opening the site menu from a long article slides the article out first (full height). After that slide, the frame settles so the footer sits at the bottom of the shorter menu page. The footer then fades and moves in from below. Height is flex-column, not a measured canvas/min-height.
- Footer includes Play Store and App Store badges (App Store is coming soon).
