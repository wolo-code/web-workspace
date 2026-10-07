# App sections

The Bottom Notification Bar (`#notification_bottom`) sits above modal dialogs and the Overlay Layer.

## Bookmarks modal

Saved tiles show the title, optional segment, and compact Go button in the bottom-right corner with padding while collapsed. When expanded, Go moves to the bottom-right of the full tile with space below the details. Go opens the saved location; tapping the rest of the tile expands the Wolo Code and street address. The three-dot menu provides icon-labeled Edit, Sync to cloud for local bookmarks, and Delete. Its size and right inset match Go. Titles and indented subtitles stay left-aligned; clicking their header does not select text or display a caret. The expanded Wolo Code block is horizontally centered as a group. Within it, the first letter of the city and the first letter of the first code word share exactly the same x-position, matching the info display layout. The leading slash sits to the left of their shared text edge. Street address lines stay centered.

The add/edit form contains Title, Segment, Address line 1 (optional), and Address line 2 (optional). Users can provide either or both address lines, or leave both blank. Saved lines display together in the expanded tile and map Address Panel. Existing bookmarks remain editable.

Local bookmarks have an info icon in the top-left corner. Clicking it shows storage and sync guidance in the bottom notification pill. Sync to cloud is in the three-dot menu. Sync is dimmed while signed out and opens sign-in when clicked; while signed in, it saves the bookmark to the cloud before removing the local copy.

Guide captions: the decode scanner and its parent stay above the guide overlay. Scan and Saved captions appear above their decode buttons; the map Saved caption appears below its bookmark button. Previous stays enabled during the guide even when city history is empty; its normal availability returns after dismissal. Static copyright footer text hides the browser caret without affecting input cursors.

The Map View scanner and search artwork use the primary accent (#69B7CF).

The profile artwork (default icon and signed-in avatar) is 42px with a padded tap target. Narrow Map View centers the bookmark and profile horizontally in the spaces beside the logo and vertically in the header. The logo fits between the reserved control spaces.

The label and Info modal logo groups share a 12px right offset with the centered main-page logo. The desktop main-page logo shifts toward the right edge without extending beyond the viewport.
