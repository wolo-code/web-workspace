

## Map camera navigation

- Bounds-based zoom uses the full projected area, the map canvas size, and the same padding as the final fit, preventing a zoom-in overshoot followed by a zoom-out correction. Dateline-crossing bounds and the viewport minimum zoom are respected.
- Manual wheel, touch, drag, double-click, and camera-key input cancel pending focus timers and pan callbacks. A newer location selection, map-source change, or return to Wolo Code Input View also cancels obsolete camera work.
- Trackpad pinches reported as Ctrl+wheel ignore small direction reversals within a gesture so a slight movement at the end of a zoom-out does not trigger a zoom-in step.
- Focusing the current map center starts zoom without waiting for a no-op pan. Provider zoom clamps end the animation without repeated steps.

## Country regions and city menu actions

- Country-level regions extend the registry with 257 country/territory namespaces, for 578 active named regions. Existing physical-region indices remain unchanged. Conflicting names gain a Region qualifier (e.g. Australia Region); unambiguous admin-0 three-letter codes are accepted as aliases.
- The nearby, matching-name, and previous-city pickers share **Cities** and **Regions** tabs styled like **Info Full View**. Searches find registered cities by name and regions or countries by name or alias. The picker works with empty history. Recent city queries reuse a short-lived cache, and region search uses a prepared name and alias index.
- A region covering the map pin uses its calculated anchor and keeps the pin in place. Selecting a region without a calculated anchor opens the **Wolo Code Input** with the region name filled in and the cursor ready for the index. Previously used indexed references are available under **Regions**.
- Calculated and previous regional references retain the outlined monospace index badge. Map info windows and printed or downloaded labels also use monospace digits.


## Named regions and city proposals

- City-based three-word codes retain their existing origins and encoding. Unavailable or out-of-range cities can fall back to a named region and compact local anchor index using the same word codec.
- The bundled frozen physical v1 registry activates 321 source-matched regions; 160 additional names remain pending. Twelve fallback namespaces cover every half-degree global tile. Overlapping region/index references can share one center and identical three words.
- The Address Panel shows address details and code QR actions without Code reference or Propose a city controls. Regional links, previous contexts, and saved addresses resolve locally, including offline. See the app's `docs/REGIONAL_ANCHORS.md` for fixed geometry conventions, provenance, polar handling, and compatibility.
- The full Info view has City and Region tabs. A centered pipe separates the tabs, and the gradient below them peaks beneath the selected label. The Region tab explains the anchor index with a centered Nepal example and a Mount Everest caption aligned with the right end of the fading rule. Both examples start with inline “e.g.”.
- After the request is acknowledged, the user's email composer opens to support@wolo.codes with `Wolo add city request <request-id>` in the subject and editable details in the body. The saved request ID and **Add details by email** fallback remain visible. Failed writes do not announce success or open drafts; duplicate in-flight clicks are ignored.
- The admin request console supports proposals without coordinates; the reviewer selects a center. Admin notification subjects also include the request ID.

## Web App Features

Bottom notifications stay above modal dialogs and their dimmed overlay so modal action feedback remains visible.

### 1. Primary Map Experience

The map info window scrolls when its content exceeds the available width or height, keeping the Wolo Code and location actions accessible on macOS Safari and in small map views.

- Full-screen Google Maps UI, with optional OpenStreetMap, Apple Maps, Esri, and Microsoft Maps tiles.
- Default map opens globally at a zoom that fills the viewport height (no blank bands at the top or bottom), then moves to a detected or selected city/location. Switching from Wolo Code Input View waits for the Google map object before calling `setMapTypeId`, so an early tap does not throw.
- Supports terrain/map, Google Satellite view, OSM, Apple Maps, Esri, and Microsoft Maps modes.
- OpenStreetMap caps manual and automatic zoom at level 19, including when switching from a deeper zoom on another source. **Map data not yet available** appears when tiles fail at a supported zoom level. The camera keeps stepping out while tiles remain unavailable, down to the minimum zoom. Failures during a zoom transition are retried, and tile events from older zoom levels are ignored.
- Tap **Switch map** to cycle forward through enabled map modes or hold it for half a second to cycle backward. Hold **Info** for half a second to show the icon guide directly in the current view.
- Profile menus (account and login) let you enable or disable Google Maps, OSM, Apple Maps, Esri, and Microsoft Maps, and set one enabled source as default. The default inbound arrow sits before the enable toggle. Only the active default inbound arrow stays visible; an inactive inbound arrow appears when that map source row is hovered or focused. Extra padding sits below the last map source row. The default map source label uses the primary accent. Appearance theme tiles have extra space between them. Theme icons stay large until hover or focus, then shrink so System/Light/Dark labels can appear. The selected theme keeps its label visible in the primary accent. Light-mode theme icons stay gray instead of using the primary accent; dark-mode hover uses a gray highlight. Section headings use the muted dialog label color, not the primary accent.
- Includes floating controls for account, location, info (Wolo Code Input View and map views, before Wolo Code input on the map), Wolo Code input (map views), map-type switcher in the bottom-right corner (map views), notifications, and footer links. Those icon controls show native hover tooltips except the appearance theme buttons. The first two launches show icon captions on the Wolo Code Input View background, not the map (light mode keeps that background; dark mode adds an 80% dark overlay), and only after the user proceeds on the first-run intro modal; a tap anywhere or a 4-second timeout from `Vars.tsv` `icon_guide_timeout` fades it away. The Info modal's bottom-left **show guide** button closes the modal and shows that overlay again on the current view, including map views; hover does not underline the button. Map View captions include Previous, Search, Go, and D-pad, plus a sample Location Wolo Label View (`Wolo-infocard-sample.svg`) with larger callout titles, italic short descriptions, and leader lines that end in circle dots on City, Wolo Code, Address, Open, and Label; a tap on the map or the 4-second timeout from `Vars.tsv` fades that overlay without freezing the tab. Map View guide uses a `World-map.svg` backdrop on the input-view fill (teal land in light mode, brand-accent land in dark mode) instead of a blank wash. OSM still uses that input-view fill rather than an 80% dark overlay. Wolo Code sits to the right of its icon and D-pad to the left of the camera control. The search bar, Go button, and complete camera control stay above the dimmer. Controls in Map View (Place Search Input, Bookmarks, Account, Info, Wolo Code, Locate, Switch map, and Camera D-pad) replicate the transparent background effect of the Go button (#decode_button, using rgb(255 255 255 / 50%) in light mode and rgb(34 34 68 / 50%) in dark mode with frosted glass blur). Search and Go are lifted above the page scrim so they stay readable as solid themed fields, without an extra accent ring. The centered caption cluster stays vertically middle and can shift up on very small screens so bottom notifications stay visible. The map camera dpad sits on the same vertical band as Locate, matching the 39px map-type disc with a small gap to its left. Locate from Wolo Code Input View switches to the default map view and starts geolocation. In Wolo Code Input View, Saved sits beside Info on the left and the folded-map button sits beside Scan on the right. The Google street map icon in the map-source switcher uses the primary accent (#69B7CF).
- Google’s logo and map-data credit stay on Google terrain/satellite only; OSM, Apple Maps, Esri, and Microsoft views hide that branding. Non-Google OSM/Esri/Microsoft attribution sits bottom-left after a small gap from the bottom-left chrome, close to the bottom edge, and stays on one line on widescreen. Apple Maps shows MapKit’s logo without a blur overlay or an extra Apple text label.
- Apple Maps follows the Google overlay during drag with a CSS transform and only recommits MapKit’s camera on idle, zoom, or a large pan.
- Location Wolo Label View (map InfoWindow) uses a dark card and high-contrast Wolo Code text in dark mode.
- Address Panel follows light/dark theme, shows plus code in India as well as DIGIPIN with labels on the left and code values on the right, copies DIGIPIN in uppercase, copies drag-selected text without replacing the highlight, stays open after navigating with a DIGIPIN or plus code, and hides when Locate starts. Small QR icons sit after the street address (bottom-right) and after each DIGIPIN and plus code (to the right) and open a modal with that value as a QR code. Opening a saved address keeps the decoded latitude (the bottom panel no longer shifts the camera north). Saved title is the parent line and segment is indented beneath it, matching the account list. Bottom toasts and the accuracy strip stack above the Address Panel in a shared flex dock so they do not overlap when the panel grows.
- Supports URL/query-driven startup:
  - Path-based Wolo Code decode links.
  - `_` suffix for satellite map startup.
  - `?q=lat,lng` startup for external geo intents.
- Shows loader, top/bottom notifications, and recoverable error dialogs. The first-load bar remains one continuous cycle across bootstrap, IP-city lookup, and its retry delays; initial service-worker activation takes control without reloading the page into a second cycle.

### 2. Encode - Map Location to Wolo Code

- User can switch to map mode and choose a location on the map.
- In Map View, hold a marker to fine-tune the location with a draggable crosshair and one-pixel directional nudges. The **Pin Adjustment D-pad** repeats one-pixel nudges while a directional button is held. The initial marker drag keeps the map still. Releasing restores map gestures, and the **Camera D-pad** stays available during adjustment. The checkmark applies the move and refreshes the marker's Wolo Code, address, and route links. The × or Escape discards the draft. Saved bookmarks keep their stored coordinates.
- User can use current GPS location to encode the current position.
- User can search for a place and encode that selected location. In Map View the search field stays focused so typing can start without clicking it first, except during the icon guide, when the caret is hidden.
- Reverse geocoding extracts the city-level Google Place ID.
- Firebase Realtime Database resolves city metadata and city center.
- Wolo algorithm encodes the selected coordinate into three 10-bit word indexes.
- Word indexes are mapped to the 1,024-word Wolo word list.
- App shows the generated Wolo Code with its city context.
- Locations outside a city's encode coverage (about 32.8 km from the city center) show **Area not covered** instead of repeating the same invalid code.

### 3. Decode - Wolo Code to Map Location

- User can enter a Wolo Code address in the format `City Word 1 Word 2 Word 3`.
- Enter in the Wolo Code input runs Go. Shift+Enter inserts a line break.
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

### 6. City Proposals

- The **City Proposal Modal View** collects city requests when the existing city-coverage workflow offers it.
- Acknowledged database requests display their ID and open an editable email draft with that ID in its subject; a fallback link remains available.
- Requests await review without an indefinite processing spinner. Network or permission failures preserve the form for retry.

### 7. Place Search

- Nearby and matching-city choices share geographic headings and dotted branches to selectable cities. **Choose city or region** opens with the **City** and **Region** tabs at the top, shows the **Anchor Icon** opposite the **Close Button** with matching top and side spacing, and highlights the current reference in its tab. Nearby alternatives carry **Nearby** tags.

- The web app includes Google Maps Places support.
- User can search for a particular place.
- A selected search result becomes the active map position. Encoding prefers its registered city, then the closest registered city whose code grid covers the position, then a regional code.

### 8. Account, Login, and Saved Addresses

- Supports Firebase Authentication via FirebaseUI.
- Shows login/sign-up dialog.
- Shows account dialog with display name, email, profile photo, appearance, and map source prefs.
- Allows logout from an icon to the right of the name and email; the icon appears when hovering or focusing the profile photo, name, and email block (always visible on touch).
- Shows saved address list with loading, empty, and end states. The list starts collapsed. Caret then plus sit on the right of the Saved heading; caret expands or collapses the list, and plus expands the add-current-address form. Clicking Saved or the empty space up to the caret also toggles the list. Expanding the list folds Appearance and Map source above it, keeping the profile picture row. The profile, Saved heading, and add form stay put; only the address list scrolls. The list parks its scrollbar in the tile inset, with matching space on the left, so address tiles stay centered and keep the same width when the bar appears, and the scrollbar uses theme colors in light and dark mode. The dialog keeps a fixed width so expanding a saved address does not change it. Expanding a saved row animates the Wolo Code, street address open, and the dialog height grows with them. The Wolo Code is the first expanded block, left-aligned as a group at the same indent as the segment with its internal alignment preserved, in the map-label format: a city line (`\ city`) above the words (`word-1 word-2 word-3 /`), with the first letter of the city and the first letter of the first code word at exactly the same horizontal position. The leading slash occupies its own grid column to the left; the city and code words share the second column, and the complete code block starts at the segment indent. The street address follows in centered Roboto gray text. When both address lines exist, a blank line separates them in the expanded tile; a single nonempty line gets no extra gap. Saved tiles are rounded on all corners. Tile headers keep their full tile width when expanded and suppress text selection and caret display when clicked. The Wolo Code block and segment share a left indent; the title and subtitle stay anchored on the left. The title is the left-aligned parent line; a left-aligned segment is indented beneath it as the child, with padding below. A three-dot menu on the top right of each saved address holds icon-labeled Edit, Sync to cloud (for device-only bookmarks), and Delete; its 30px button and 18px icon align with Go at a 6px right inset; on hover-capable pointers it appears only on tile hover, keyboard focus, or while the menu is open. In dark mode it uses the primary background with white dots. Edit opens the add form with that address's title, segment, and optional address. A split/merge icon toggles one Address field into Address line 1 (e.g. 12 MG Road) and Address line 2 (e.g. Flat 4B, second floor). Existing two-line entries open split. Merging joins nonempty lines with a comma and remembers the split until the merged text is edited; saving merged always stores the full text as line 1 and clears line 2. Either or both lines may be blank. Device bookmarks, cloud saves, offline queues, and sync store separate `address_line_1` and `address_line_2` fields. Legacy street text is read entirely as line 1 and converted on edit/sync. Map panels, QR labels, copying, and exports display nonempty lines in order. The label prefills Title with the selected Google place name, Segment with its unit or suite when provided, and Address with the formatted place address or the resolved street address. Existing label edits and saved details take precedence. Title and Segment fields hint with `e.g. Home` and `e.g. Main gate`, and the title, segment, and address fields share the same left inset as the tiles. Cancel sits on the left of the save section and Save stays on the right. Saving requires a located or decoded Wolo Code, except when updating an existing saved address. Go is always available in the bottom-right corner of the saved tile and moves to the bottom of the full tile when expanded, with a compact 30px button, an 18px icon, and 6px inset padding, and opens it on the map at the decoded location, with the Address Panel showing that title and an indented segment.
- Device-only bookmarks show an info icon at the top-left instead of an “On this device” label or a modal-wide storage notice. Clicking it shows browser-only storage and sync guidance in the bottom notification pill. Sync to cloud is an icon-labeled item in the three-dot menu. Signed-out users see a dimmed, aria-disabled Sync button that prompts sign-in when activated. Signed-in users can sync an individual bookmark; its local copy is removed only after the cloud write succeeds. Failed syncs retain the local bookmark, and retries use a stable cloud key.
- Save current address from QR Label View (title, segment, address, and a top-left address-book save icon). Title and Segment fields hint with `e.g. Home` and `e.g. Main gate`. Preview uses an eye-only icon. Clicking the dimmed overlay outside the dialog closes it. A successful save shows **Address saved** above the overlay. Refreshing the address book does not replace that with a city-lookup error. Saved rows show the Wolo Code as `\ city` on the first line and `word-1 word-2 word-3 /` on the second.
- Saved addresses can preserve Wolo Code plus user-entered metadata/address text.

### 9. Code Presentation, Sharing, and QR/Print

- The Label modal also provides the optional Address split/merge control with line 1 and line 2 examples. Existing two-line addresses open split; toggling preserves boundaries until merged text is edited. Saving while merged stores the displayed text as line 1 and clears line 2. Preview, print, and image exports show only the address text, preserving split lines and excluding the editing controls and placeholder examples. Closing and reopening the label restores its address fields.

- Web app has a printable/shareable Wolo Code layout.
- Copying a Wolo Code link writes only the URL as plain text, including the trailing slash for a jump link.
- Includes title, segment, Wolo Code, editable address, and `www.wolo.codes`.
- In the Label modal, the three Wolo Code words use dark teal (#1F4E5F) in edit mode and 80% black (#333333) in preview mode. The top border, corner frame, and “scan or enter at www.wolo.codes” footer use the primary accent (#69B7CF) in both modes.
- Copied Wolo map links include the current `zoom`. Links without a valid zoom open two levels below the active map source’s maximum. The link-opening dialog has a Close button in the top-right corner.
- The Label modal’s **Download** button saves a PNG with the complete Wolo Code logo at its preview size.
- Supports print.
- Supports saving the current Wolo Code address from the bookmark button to the left of the Label heading, with Close on the same row to the right. Both buttons have a tinted fill and outline on narrow screens in light mode.
- Uses `html2canvas` and `jspdf` for export-oriented rendering.

### 10. External Navigation / Maps Redirect

- Direct Wolo Code links start in Map View with the Address Preview visible. Its slightly rounded panel uses larger type for the Wolo Code words and vertically centers the decoded address or 36 px loading spinner in the four-line address area. The Close button is centered 20 px below the panel. Trailing-slash links use its External Map Redirect mode, with the page-wide loader visible above the overlay. The external map opens three seconds after the code resolves.
- Stop keeps the location open in Wolo.
- On narrow screens, Address Preview and External Map Redirect show the Wolo logo above the panel, with the Code wordmark aligned near its base, and the page footer below. In light mode, the Close button has a tinted fill and outline for contrast against the white background.
- Profile settings remember the external map choice for this browser. Choices are Automatic, Google Maps, and Apple Maps.
- Android wrapper forwards geo intents to `https://wolo.codes/?q=...`.
- Decoded or selected coordinates can be handed off to a maps app.

### 11. Informational and Legal UI

- Intro explains the Wolo Code address format. The Info modal is vertically centered; dark mode drops the light outline around the brand lockup. On narrow viewports the full-screen overlay uses the dark dialog background in dark mode, and the first-run intro keeps a small gap between the author credit and the version number. A **show guide** button in the bottom-left corner hides the modal and shows the icon caption overlay on the current view (Wolo Code Input View or Map View). Hover does not underline that button. The bottom-right label shows `v` plus the three-part `version` from `Vars.tsv` on the same bottom line as **show guide**. Hover or keyboard focus expands the label to `version.build` and shows elapsed time since the bake under the version. Hovering that stamp shows the UTC timestamp. A tap keeps the full version visible and shows local time under the version; hovering that local stamp shows UTC. Times overlay below that line so the version stays put. The credits/links view includes crawl-proof `support@wolo.codes` and linked map credits (OpenStreetMap, Esri, Microsoft, Apple Maps, Google Maps). That view does not show **show guide**, a version number, or an updated timestamp.
- Shows sample input such as `Bengaluru cat apple tomato`. Choosing **Try: Bengaluru, India** pans to that sample and animates zoom-in to street level.
- Links to:
  - About
  - App Launch (`/press_release/launch`): responsive Launch Illustration, fixed-width Wolo Code Examples, and Get the app link
  - Technical Paper (`/paper`): LaTeX-aligned Equations and Diagrams with dark-mode diagram contrast, linked References, and Download PDF with A. Process starting page two
  - Terms of use
  - Privacy policy
  - Credits (`/credits`: location codes, maps, browser, and icons)
  - Source code
  - App download page
  - Contact email (`support@wolo.codes`)
  - Social pages
- Shows the first-run cookie/privacy notice on the app home page. Direct Wolo Code, coordinate and route links open their destination without the intro or automatic icon guide. The Info dialog still provides the privacy policy and manual guide.
- Shows unsupported browser warning.
- Shows a blocking unexpected error dialog titled `Oops an error occured!` with a warning icon, Clear cache & reload, and a crawl-proof support email on the next line after “You may contact our support team.” There is no close button. Press and hold the title to show the crash message and Continue. Clicking the dimmed overlay does not close it. Other overlay dialogs close when the overlay is clicked.
- In Map View and Wolo Code Input View, press and hold the Wolo logo to clear the app cache and reload. The logo disables the iOS Safari touch callout so the link preview does not intercept the gesture.
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

Status messages use theme-aware frosted glass over the frozen Viewfinder. Status and privacy messages appear above the controls in live capture and manual entry. Flashlight joins Gallery and Typing in the live control row on supported cameras and switches off when the camera is released. Rescan sits at the top left of Label Edit View for scanned and typed labels. The Bottom Controls Panel keeps Save on the left, Address Details in the center, and Go on the right while the fields scroll. Save and Go sit 24 px in from the dialog edges. Go's background and arrow follow the active theme. The camera artwork fills more of its circular button, and Bookmarks uses the matching dark-mode disc background.

Scanner review: A List icon button to the left of the editable city opens recognized, recent, IP and selected city choices; selecting a city updates the scanner review only. City and Word labels use a faded accent, recognized values use larger type, and Address details and bookmark Save sit below the label fields.

The scanner city chooser icon sits inside the left edge of the city input.

Scanner compact controls: City input is centered at 75% width, with an anchored city-choice popup that dismisses on selection, outside click, or Escape. Wolo Code Input View orders city-source controls as Previous city, IP globe, then GPS.

Zoom Controls sit in a horizontal row below the Viewfinder. Reset Zoom sits between Zoom Out and Zoom In. It shows a magnifying glass at 100% and the current percentage at higher zoom levels. Press it to return to 100%. Each control shows a circle on hover, press or keyboard focus. The Viewfinder uses a solid background during live scanning and a chequered background behind the frozen label preview. Both backgrounds follow the active theme. Rescan returns from Label Edit View to an edge-to-edge live Viewfinder. The preview and recognition use the same centered crop at the current live zoom.

When the first scan misses, the scanner can fit four edges around a card or code frame and flatten the resulting quadrilateral before retrying OCR. It checks the corrected image for a valid code box and maps the recognized regions back to the original preview. If the whole card is corrected, the optional details read uses the corrected card too. Whole-frame tilt correction remains available when the border-based read fails.

Scanner City label sits just outside the input's left edge with an 8px gap, preserving the city field and embedded chooser positions.

Scanner city choices open in a centered modal popup when the city icon is clicked, above the scanner with a dimmed backdrop. Selection updates the review city and dismisses the popup; Escape or backdrop click also dismisses it.

Holding the Scan Button for 500 ms opens the Wolo Code Scan Dialog in debug mode. The scrollable Scan Debug Log reports elapsed times for camera startup, detection, OCR and each processed frame. It follows new entries while at the bottom and holds its position while reading earlier steps. It pauses in Label Edit View, resumes on Rescan, and clears when the dialog closes.

In Label Edit View, empty optional details shimmer while OCR reads them and fill with recognized text once the read finishes. Fields stay editable, and OCR preserves user edits. Reduced-motion settings show a static loading tint.

Scanner review validation: All three words must match the Wolo word list, ignoring case and surrounding spaces. Empty and possible word prefixes stay neutral gray. A nonempty entry with no matching word prefix turns red and shakes; a three-second popup names the wrong word when it first becomes impossible. There is no persistent inline error message. Go and Save stay disabled until all three words are complete and valid. City uses the same underline as the three word fields.

Scanner detection adds 10% centered padding around recognized text and fills review fields immediately on live capture. Zoom and pan automatically rerun framed OCR after 350ms of inactivity, ignoring outdated results. Live zoom requests fresh detection.

Scanner gallery photos preserve native pixel dimensions for the preview, original source and OCR; zoom and pan no longer use a photo reduced to 1600px wide.

Scanner recognition detects the actual printed rectangle or rounded rectangle first, reads three Wolo words inside it, and reads the city above the words within that same box. Title/segment above and address below are optional separate match metadata. No golden-ratio container is inferred from text; dictionary correction applies only to the code words. Blue container, gold city and green word outlines follow capture and framing changes.

Map View: Scan is inside the right end of the search field. Wide layouts use a rectangular Bookmarks button flush against the search bar's left edge; narrow layouts keep Bookmarks above the search row.

Guide captions: the decode scanner and its parent stay above the guide overlay. Scan and Saved captions appear above their decode buttons; the map Saved caption appears below its bookmark button. Previous stays enabled during the guide even when city history is empty; its normal availability returns after dismissal. Static copyright footer text hides the browser caret without affecting input cursors. In map views, the copyright year link is white with a dark shadow for contrast over map tiles.

The Map View scanner and search artwork use the primary accent (#69B7CF). Both Map View and Wolo Code Input View use `Scan.svg`, a scanner icon with four corner markers and a centered filled rounded rectangle.

The profile artwork (default icon and signed-in avatar) is 42px with a padded tap target. Narrow Map View centers the bookmark and profile horizontally in the spaces beside the logo and vertically in the header. The logo fits between the reserved control spaces.

The label and Info modal logo groups share a 12px right offset with the centered main-page logo. In Map View and Wolo Code Input View, the Code wordmark matches the size in the Info modal. Code sits beside Wolo on narrow screens and below it on desktop. The desktop main-page logo keeps a 10px gap from the right screen edge.

In both Saved and Label modals, the address split/merge icon appears only while the address editor or its toggle has keyboard focus. The icon sits at the bottom-right of the address line 1 field. Its gray lines stay the same in both states; only the filled primary-accent (#69B7CF) triangle changes direction, pointing down to split and up to merge.

Wide Map View uses a 42px by 42px bookmark container joined without a gap to the left edge of the search input.

Saved-address navigation and the info-window Address action use the same Address Panel renderer. Both preserve the separator between saved address lines and show the address QR button whenever the address has nonempty text. The QR payload retains both lines in order.

Hold the Scan Button for 500 ms to open the Scan Debug Log and enter Region Inspection. The Scan Frame uses bright moving dashes in live debug mode and a bright solid border on the frozen image or with reduced motion.

Scanner card and optional details: the Wolo Code Scan Dialog first looks for straight or rounded card boundaries across the available image. When a portrait Card Region covers the current focus, the scanner searches inside it for the smaller landscape Wolo Code Region before searching for markers elsewhere. OCR starts inside the code box. When a close-up clips the outer card, the scanner searches the full camera viewport and reads the inner Wolo Code Region on its own if its frame is visible. Live confirmation searches a padded crop around the previous card when it fits within half the frame. If the code box or card has moved outside that crop, the scanner searches the full frame again. Still-image OCR tries the inner code box with block and sparse-text modes before trying the card crop. Optional detail reads stay inside the detected card. The dashed Scan Frame guides alignment across the full visible camera image. Review zoom and pan define the visible photo crop for detection and OCR. The Address icon expands optional Title and Segment fields above the city/words section and Address line 1 and Address line 2 below it, matching the card. The existing Go arrow opens the reviewed address; there is no duplicate caret action. Cancel is a circular Close icon button with an accessible label. The modal grows with its content up to the viewport height with a gap above and below to reveal its extent before its body scrolls. A bookmark Save action saves the reviewed city, words and optional details directly while keeping the scanner open; Title is required for saving, and signed-out saves stay on the device. Title and Segment are separate rows above the inner box; both address parts are below it inside the card, line 1 first with blank-paragraph spacing before line 2. Wrapped rows stay in their paragraph. Edited values survive recognition of the same card and flow into the decoded location and its label/save editors on Use address. If Address details are expanded when Use address is chosen, the Address Panel opens immediately on decode with the recognized or edited address and stays open after reverse geocoding; collapsed details retain the normal closed panel behavior. The core code remains usable when the card or optional text is unreadable. Region Inspection can show the portrait Card Region in purple as soon as its boundary is detected, even before the blue Wolo Code Region is found. The full preview stays visible for reframing.

### Location and map flow reliability

- Background app updates preserve the current location result instead of reloading to the starting screen.
- Completed or superseded geolocation watches ignore queued results and errors. Timeout/unavailable errors do not revoke location permission; only permission denial does.
- Switching away from Apple Maps hides its stage and cancels its follow frame; delayed MapKit loading cannot reveal an inactive layer.
- Google POI clicks are used only on Google terrain/satellite. Other map sources resolve the clicked coordinate instead of a hidden Google place.


## Multiple map places and route sharing

Shift+Go retains the current info card while opening another. Info cards have no close button. Backspace or Delete removes the active card and its marker, or the focused Places row; typing in a nonempty search field or another editable field keeps normal editing behavior. Click a retained card to make it active before removing it.

The primary-accent Places icon uses two list items, shows a **Places** hover tooltip and opens the ordered list when at least two places exist. The rounded panel matches the controls’ glass treatment (50% white in light mode, 50% dark blue in dark mode, with 4px backdrop blur). Place names begin with a capital letter and have a faint text halo for contrast over the glass. Soft rows use letter badges matching the map markers: A–Z, then AA–AZ, BA, and onward. Map-marker letters have a faint white glow for legibility. Each row places the remove control to the left of the drag handle at the far right. The drag handle uses an equals sign; both it and the remove control have faint backgrounds and appear on row hover or keyboard focus (always visible on touch devices). A horizontal line between rows marks the drop boundary, with the upper/lower half of a hovered row selecting before/after. The drag handle supports mouse/touch reordering; focus the handle and use Arrow Up/Down for keyboard reordering. A hover or keyboard-focus **×** removes that place and its marker; touch devices show the remove control continuously. Removing or reordering places refreshes the letter labels and route order. When multiple places exist, the Address box shows the active marker’s letter in a circle at the top-left, with slight padding around the top caption line; the badge disappears for a single place. Info cards omit the letter badge.

The bottom icon toolbar uses the existing external-link icon for **Directions** and the existing share icon for **Route**. Tap/click Route to share a Wolo Code based URL. Hold it for 500 ms to share a coordinate based URL. Sharing uses the native share sheet where available and copies the link otherwise. Both URL types use `/?from=...&via=...&to=...` with repeated `via` parameters for additional stops. Wolo routes preserve each opened card's full city/region reference and three words; unopened search results use a globally resolvable regional Wolo Code. Coordinate routes preserve latitude/longitude directly. Both formats restore all ordered markers and fit them in view; Wolo decoding waits for the word list and resolves the complete route before adding markers. Invalid or unknown stops show an error. Select a marker or row to open its info card. Directions follow the list order and split long routes into overlapping batches for mobile Maps support.

City-list, Go, Places, external-link/Directions, route-share, and address icons share a subtle 8% grow on hover and keyboard focus. The artwork scales over 240 ms while hit targets and captions stay stationary; reduced-motion preference removes the transition.

## Wolo Code Scan Dialog

The scanner filters label branding and blank OCR rows from optional details during both initial OCR and follow-up reads. The first readable address paragraph fills Address line 1.

The OCR worker can preload during page idle and is reused when the dialog opens. Gallery starts OCR setup before file selection and decodes the selected image while the worker gets ready. With three exact, high-confidence words, Label Edit View can open with a blank city. If a second read is needed, the Wolo Code Scan Dialog checks sooner and starts with the previously read code box. The Top Bar Loader stays visible through the Input Icon Guide’s full closing fade.

The Wolo Code Scan Dialog reads landscape labels from native camera pixels and can straighten a slightly tilted label. Label Edit View opens after one high-confidence read or two matching three-word reads in the same region, with one missed frame allowed. Gallery reads the detected code box first and can retry with sparse-text OCR. Label Edit View shows the city and words while optional details finish reading. A successful capture shows the message "Please verify the code below". Review the fields and choose Go to open the address.

## GIS Integration Guide (marketing site)

- `/meet` redirects to the Google Calendar appointment scheduler. The Site Footer right-aligns **Updated** across marketing pages.

- `/gis_integration` presents an SDK-first evaluation path for GIS and location platform teams. It keeps geometry and spatial analysis in the customer's GIS, explains coordinate/reference and ordered-word-list considerations, and provides an evaluation checklist, a requirements email, and a meeting scheduler linked from the page and PDF.
- The page links to the Wolo web app for a coordinate demonstration and to `/gis-integration-guide.pdf` for a printable client brief, downloaded as `wolo-gis-and-location-platform-integration-guide.pdf`. Examples are conceptual; SDK targets and signatures are not presented as released contracts, and a hosted API is not required by the guide.

The **Technical Paper** metadata row displays **IEEE Conference Paper Format | doc v1.2.0 | Download PDF** on one line, with **| doc v1.2.0 |** anchored exactly at the horizontal center using equal-width side columns. The paper footer places the version on the right; **Updated** remains at the bottom in the **Site Footer**.

The **Technical Paper** **Download PDF** link places its download icon after the text.

The **Technical Paper** **Diagrams** and **Download PDF** show the full-height double-headed dimension arrow for Θ and D in Grid G.

The **GIS Integration Guide (marketing page)** explains grid rounding: about 1 m per axis and about 1.4 m maximum horizontal displacement for a roughly 2 m grid, in addition to source measurement error.

The **GIS Integration Guide (marketing page)** See also links use **Wolo Code** for the technical paper and word list.

The **GIS Integration Guide (marketing page)** describes coordinate precision in decimal degrees and arcseconds, latitude-dependent longitude spacing, and the distinction between coordinate precision and positional accuracy.
