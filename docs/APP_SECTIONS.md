# App sections

Direct Wolo Code, coordinate and route links skip the first-run Info notice and automatic guide. Open Info to find the privacy policy or select **show guide**.

## Wolo Code Input View

Press Enter in the Wolo Code field to run Go. Shift+Enter inserts a line break.

## View and map-source controls

In Wolo Code Input View, Saved sits next to Info on the left and the folded-map button sits next to Scan on the right. In Map View, the left button shows the Wolo Code mark and the map switcher on the right shows the next map source. The Google street map icon uses the primary accent (#69B7CF).

## Map View: camera navigation

Wolo map links accept `?zoom=17` and keep the requested zoom within the map’s supported range. Without a valid zoom, links open two levels below the active map source’s maximum. The dialog shown when opening a link has its Close button at the top right.

The Terrain Map Canvas and alternate map sources keep manual pan and zoom in control: wheel, touch, drag, double-click, and camera-key input cancel automatic location focus, including its delayed final fit and chrome pan. New location selections, map-source changes, and entering Wolo Code Input View discard earlier camera callbacks. Bounds focus uses the full projected bounds and actual map dimensions with consistent padding, including across the dateline, so it does not zoom in too far before fitting back out. Focusing the current center works without a pan event, and camera limits stop animation cleanly.

Map View filters small direction reversals within trackpad pinches reported as Ctrl+wheel while allowing a sustained reversal or a new pinch to change direction.

## Map View: OpenStreetMap coverage

When location navigation or auto zoom reaches unavailable OSM tiles, the map steps out until tiles load or the minimum zoom is reached. The **Map data not yet available** notification accompanies missing-tile fallback. Tile failures during a fallback transition remain eligible for the next zoom-out step; events from older zoom levels do not affect the current view.

## Country and regional choices in city selectors

Nearby and matching-city lists show each shared geographic path once, with dotted branches to the city buttons. A standalone result shows its full path, and each grouped button has its full path as its accessible name.

Map View place search uses a city as the code reference when a registered city grid covers the selected position. The country or regional reference is the fallback.

The nearby, matching-name, and previous-city dialogs include the shared `CityRegionOptions.php` panel. Matching-name and previous-city dialogs list relevant country and regional anchors under **Use a regional code** and offer manual region/index entry there. **Propose a city** opens the existing proposal form. Empty previous-city history no longer disables the menu. The map selector has **Cities** and **Regions** sections. The active section opens first with the current reference highlighted across its full row at the top. Unselected city and region rows share the same style. Alternate city rows carry **Nearby** tags. **+ Propose a city** sits under Cities, and **+ Enter a region and index** sits under Regions and opens a modal. Both actions align to the right, and region cards line up with the city branches. Geographic headings use an accent color.

Regional references show an outlined numeric index badge immediately after the name in the regional choices. The manual region/country selector and anchor-index input are indented 16px beneath their labels and have underline-only borders, followed by a left-aligned filled **Use regional code** button. The matching-name and previous-city dialogs align their outlined **Propose a city** button to the right. Regional indices use clear monospace digits here, in the map info window, and in Label view and its print/download output; minimal PDF labels use Courier for the index.


The Address Panel omits the Code reference selector and Propose a city button.

The full Info view has City and Region tabs for the two plain-text formats. The equal-width tabs keep a visible pipe centered above the fading rule, whose gradient peak moves beneath the selected label. Both examples use inline “e.g.”, and the Region tab places “Mt. Everest” below its example, aligned with the right end of the fading rule. Both panels share the same layout so the usage steps stay in place when switching tabs.

## Regional reference and city proposal controls

| Section | Controls | Behavior |
| --- | --- | --- |
| City Proposal Modal View | `#no_city_message`, `#no_city_name`, `#no_city_country`, `#no_city_include_location` | Open from city selectors. Name is required; country and selected location are optional. |
| City proposal confirmation | `#no_city_request_id`, `#no_city_email_details` | Displays an acknowledged request ID, opens an editable email draft, and retains a fallback email link. Closing does not cancel an already submitted request. |


The Bottom Notification Bar (`#notification_bottom`) sits above modal dialogs and the Overlay Layer.

Long-pressing the external maps button in the Map View info window copies the Wolo Code jump link as plain text, including its trailing slash. Direct Wolo Code links open Map View with the **Address Preview** modal already visible. The Close button is centered 20 px below the modal. The decoded address is vertically centered within the four-line area between the down arrow and Go, and longer addresses scroll within that area. The trailing-slash variant is called **External Map Redirect**. It uses the same modal with a Stop button and the page-wide loader visible above the overlay. The External map control in profile settings chooses where these links and other external map actions open.

On narrow screens, Address Preview and External Map Redirect keep the Wolo logo at the top and the page footer at the bottom. The Code wordmark sits near the base of the Wolo wordmark, as in the Info modal. In light mode, the Close button has a tinted fill, visible outline, and dark teal icon against the white background.

## Bookmarks modal

Saved tiles show the title, optional segment, and compact Go button in the bottom-right corner with padding while collapsed. When expanded, Go moves to the bottom-right of the full tile with space below the details. Go opens the saved location; tapping the rest of the tile expands the Wolo Code and street address. The three-dot menu provides icon-labeled Edit, Sync to cloud for local bookmarks, and Delete. Its size and right inset match Go. The title bar stays full-width in both collapsed and expanded states. Titles and indented subtitles stay anchored on the left; clicking their header does not select text or display a caret. The expanded Wolo Code block is left-aligned as a group at the same indent as the segment. Within it, the first letter of the city and the first letter of the first code word share exactly the same x-position, matching the info display layout. The leading slash occupies its own grid column; the city and code words share the second column so their starting positions cannot drift. Street address lines stay centered, with a blank line between address line 1 and 2 when both are nonempty. Single-line addresses get no extra gap.

The add/edit form contains Title, Segment, and one optional Address field with a split/merge icon. Splitting reveals optional Address line 1 (e.g. 12 MG Road) and Address line 2 (e.g. Flat 4B, second floor). Merging displays both lines joined with a comma and remembers their split until the merged text is edited. Saving while merged stores all displayed text as line 1 and clears line 2; saving while split stores both fields separately. Either or both lines may be blank. Existing two-line bookmarks open split; legacy address text is treated entirely as line 1. Saved lines display together in the expanded tile, map Address Panel, and QR/export flows.

Local bookmarks have an info icon in the top-left corner. Clicking it shows storage and sync guidance in the bottom notification pill. Sync to cloud is in the three-dot menu. Sync is dimmed while signed out and opens sign-in when clicked; while signed in, it saves the bookmark to the cloud before removing the local copy.

Guide captions: the decode scanner and its parent stay above the guide overlay. Scan and Saved captions appear above their decode buttons; the map Saved caption appears below its bookmark button. Previous stays enabled during the guide even when city history is empty; its normal availability returns after dismissal. Static copyright footer text hides the browser caret without affecting input cursors. In map views, the copyright year link is white with a dark shadow for contrast over map tiles.

The Map View scanner and search artwork use the primary accent (#69B7CF). Both Map View and Wolo Code Input View use `Scan.svg`, a scanner icon with four corner markers and a centered filled rounded rectangle.

The profile artwork (default icon and signed-in avatar) is 42px with a padded tap target. Narrow Map View centers the bookmark and profile horizontally in the spaces beside the logo and vertically in the header. The logo fits between the reserved control spaces.

The label and Info modal logo groups share a 12px right offset with the centered main-page logo. In Map View and Wolo Code Input View, the Code wordmark matches the size and close placement beside Wolo in the Info modal. The desktop main-page logo keeps a 10px gap from the right screen edge.

## Label modal

The bookmark button, centered Label heading, and Close button share one row above the label. On narrow screens in light mode, both buttons have a tinted fill, visible outline, and dark teal icons against the white background.

The full label uses dark text for the city and Wolo Code and displays “scan or enter at www.wolo.codes” in the footer. The top border, corner frame, and footer use #1F4E5F in edit mode and 80% black (#333333) in preview mode.

The Label modal also provides the optional Address split/merge control with line 1 and line 2 examples. Existing two-line addresses open split; toggling preserves boundaries until merged text is edited. Saving while merged stores the displayed text as line 1 and clears line 2. Preview, print, and image exports show only the address text, preserving split lines and excluding the editing controls and placeholder examples. Closing and reopening the label restores its address fields.

In both Saved and Label modals, the address split/merge icon appears only while the address editor or its toggle has keyboard focus. The icon sits at the bottom-right of the address line 1 field. Its gray lines stay the same in both states; only the filled primary-accent (#69B7CF) triangle changes direction, pointing down to split and up to merge.

Wide Map View uses a 42px by 42px bookmark container joined without a gap to the left edge of the search input. Controls in Map View (Place Search Input, Bookmarks, Account, Info, Wolo Code, Locate, Switch map, and Camera D-pad) replicate the transparent background effect of the Go button (#decode_button, using rgb(255 255 255 / 50%) in light mode and rgb(34 34 68 / 50%) in dark mode with frosted glass blur).

Saved-address navigation and the info-window Address action use the same Address Panel renderer. Both preserve the separator between saved address lines and show the address QR button whenever the address has nonempty text. The QR payload retains both lines in order.

Scanner region inspection: hold the capture camera button for 500ms to show the detected printed container, city, and three-word outlines; release hides them without capturing. A tap captures normally. The container follows the physical rectangle or rounded rectangle, including cities wider than the code row.

Scanner card and optional details: detect the inner Wolo code box and the whole card against its background separately. The initial dashed frame is only a guide; live and repeat recognition use the full image, with pan/zoom changing candidate focus. The Address icon expands optional Title and Segment fields above the city/words section and Address line 1 and Address line 2 below it, matching the card. The existing Go arrow opens the reviewed address; there is no duplicate caret action. Cancel is a circular Close icon button with an accessible label. The modal grows with its content up to the viewport height with a gap above and below to reveal its extent before its body scrolls. A bookmark Save action saves the reviewed city, words and optional details directly while keeping the scanner open; Title is required for saving, and signed-out saves stay on the device. Title and Segment are separate rows above the inner box; both address parts are below it inside the card, line 1 first with blank-paragraph spacing before line 2. Wrapped rows stay in their paragraph. Edited values survive recognition of the same card and flow into the decoded location and its label/save editors on Use address. If Address details are expanded when Use address is chosen, the Address Panel opens immediately on decode with the recognized or edited address and stays open after reverse geocoding; collapsed details retain the normal closed panel behavior. The core code remains usable when the card or optional text is unreadable. Region inspection adds a purple whole-card outline independently of the guide.

## Map and location lifecycle

Location Wolo Label View remains open across background service-worker updates. New page assets apply on the next navigation or manual refresh. Completed/superseded Location Accuracy Indicator sessions ignore queued geolocation callbacks. Entering Wolo Code Input View or another map source hides the Apple Maps stage, including when MapKit finishes loading later. Hidden Google POIs do not replace coordinate-selected results on non-Google maps.


## Multiple map places and route sharing

Shift+Go retains the current info card while opening another. Info cards have no close button. Backspace or Delete removes the active card and its marker, or the focused Places row; typing in a nonempty search field or another editable field keeps normal editing behavior. Click a retained card to make it active before removing it.

The primary-accent Places icon uses two list items, shows a **Places** hover tooltip and opens the ordered list when at least two places exist. The rounded panel matches the controls’ glass treatment (50% white in light mode, 50% dark blue in dark mode, with 4px backdrop blur). Place names begin with a capital letter and have a faint text halo for contrast over the glass. Soft rows use letter badges matching the map markers: A–Z, then AA–AZ, BA, and onward. Map-marker letters have a faint white glow for legibility. Each row places the remove control to the left of the drag handle at the far right. The drag handle uses an equals sign; both it and the remove control have faint backgrounds and appear on row hover or keyboard focus (always visible on touch devices). A horizontal line between rows marks the drop boundary, with the upper/lower half of a hovered row selecting before/after. The drag handle supports mouse/touch reordering; focus the handle and use Arrow Up/Down for keyboard reordering. A hover or keyboard-focus **×** removes that place and its marker; touch devices show the remove control continuously. Removing or reordering places refreshes the letter labels and route order. When multiple places exist, the Address box shows the active marker’s letter in a circle at the top-left, with slight padding around the top caption line; the badge disappears for a single place. Info cards omit the letter badge.

The bottom icon toolbar uses the existing external-link icon for **Directions** and the existing share icon for **Route**. Tap/click Route to share a Wolo Code based URL. Hold it for 500 ms to share a coordinate based URL. Sharing uses the native share sheet where available and copies the link otherwise. Both URL types use `/?from=...&via=...&to=...` with repeated `via` parameters for additional stops. Wolo routes preserve each opened card's full city/region reference and three words; unopened search results use a globally resolvable regional Wolo Code. Coordinate routes preserve latitude/longitude directly. Both formats restore all ordered markers and fit them in view; Wolo decoding waits for the word list and resolves the complete route before adding markers. Invalid or unknown stops show an error. Select a marker or row to open its info card. Directions follow the list order and split long routes into overlapping batches for mobile Maps support.

City-list, Go, Places, external-link/Directions, route-share, and address icons share a subtle 8% grow on hover and keyboard focus. The artwork scales over 240 ms while hit targets and captions stay stationary; reduced-motion preference removes the transition.
