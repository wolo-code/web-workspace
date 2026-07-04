
## Web App Features

### 1. Primary Map Experience

- Full-screen Google Maps UI.
- Default map opens globally, then moves to a detected or selected city/location.
- Supports terrain/map and satellite modes.
- Includes floating controls for account, location, action menu, map/code mode, map type, notifications, and footer links.
- Supports URL/query-driven startup:
  - Path-based Wolo Code decode links.
  - `_` suffix for satellite map startup.
  - `?q=lat,lng` startup for external geo intents.
- Shows loader, top/bottom notifications, and recoverable error dialogs.

### 2. Encode - Map Location to Wolo Code

- User can switch to map mode and choose a location on the map.
- User can use current GPS location to encode the current position.
- User can search for a place and encode that selected location.
- Reverse geocoding extracts the city-level Google Place ID.
- Firebase Realtime Database resolves city metadata and city center.
- Wolo algorithm encodes the selected coordinate into three 10-bit word indexes.
- Word indexes are mapped to the 1,024-word Wolo word list.
- App shows the generated Wolo Code with its city context.

### 3. Decode - Wolo Code to Map Location

- User can enter a Wolo Code address in the format `City Word 1 Word 2 Word 3`.
- City can be omitted when the current city context is known.
- Last three tokens are treated as the code words.
- Preceding tokens are treated as the city.
- Web app resolves ambiguous city names through a "Choose the city" dialog.
- Decoded location is shown on the map and can be used for downstream map/navigation actions.

### 4. City Context and City Selection

- Detects city by IP via `POST https://wolo.codes/api/cityByIp`.
- Can detect city from current geolocation.
- Maintains a current city context.
- Provides "Choose the city" flow when multiple cities match.
- Shows nearby cities when selecting city context.
- Shows a current city label in city selection UI.
- Falls back to manual map selection when location access is denied.

### 5. Location Permission and Accuracy Flow

- Presents a location-access prompt before requesting geolocation.
- Stores location permission preference and "do not ask again" state in local storage.
- Uses browser geolocation watch for high-accuracy location.
- Shows accuracy in meters.
- Shows an accuracy indicator whose color changes with accuracy.
- Provides a "Proceed" control so users can accept the current fix before the watch completes.
- Handles permission denied, unsupported browser geolocation, invalid `0,0` positions, timeout, and low-accuracy states.

### 6. Unsupported City Request

- When a selected location is not in the supported city database, the web app prompts the user to add the city.
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
- Shows account dialog with display name and email.
- Allows logout.
- Provides "Current" save UI with:
  - Title
  - Segment
  - Editable address text
  - Save action
- Shows saved address list with loading, empty, and end states.
- Saved addresses can preserve Wolo Code plus user-entered metadata/address text.

### 9. Code Presentation, Sharing, and QR/Print

- Web app has a printable/shareable Wolo Code layout.
- Includes title, segment, Wolo Code, editable address, and `www.wolo.codes`.
- Supports QR preview.
- Supports download.
- Supports print.
- Uses `html2canvas` and `jspdf` for export-oriented rendering.

### 10. External Navigation / Maps Redirect

- Shows "Redirecting to maps app" flow.
- Supports canceling the redirect.
- Android wrapper forwards geo intents to `https://wolo.codes/?q=...`.
- Decoded or selected coordinates can be handed off to a maps app.

### 11. Informational and Legal UI

- Intro explains the Wolo Code address format.
- Shows sample input such as `Bengaluru cat apple tomato`.
- Links to:
  - About
  - Terms of use
  - Privacy policy
  - Credits
  - Source code
  - App download page
  - Contact email
  - Social pages
- Shows cookie/privacy notice.
- Shows unsupported browser warning.
- Shows unexpected error dialog with optional technical log.
- Reports exceptions to Sentry.
- Uses Firebase Analytics, Firebase Performance, and Cloudflare analytics.

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
| Sentry | Error reporting |
| Cloudflare | Hosting/analytics |
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
