# App sections

The Bottom Notification Bar (`#notification_bottom`) sits above modal dialogs and the Overlay Layer.

## Bookmarks modal

Saved tiles show the title, optional segment, and compact Go button in the bottom-right corner with padding while collapsed. When expanded, Go moves to the bottom-right of the full tile with space below the details. Go opens the saved location; tapping the rest of the tile expands the Wolo Code and street address. The three-dot menu provides icon-labeled Edit, Sync to cloud for local bookmarks, and Delete. Its size and right inset match Go. The title bar stays full-width in both collapsed and expanded states. Titles and indented subtitles stay anchored on the left; clicking their header does not select text or display a caret. The expanded Wolo Code block is left-aligned as a group at the same indent as the segment. Within it, the first letter of the city and the first letter of the first code word share exactly the same x-position, matching the info display layout. The leading slash occupies its own grid column; the city and code words share the second column so their starting positions cannot drift. Street address lines stay centered, with a blank line between address line 1 and 2 when both are nonempty. Single-line addresses get no extra gap.

The add/edit form contains Title, Segment, and one optional Address field with a split/merge icon. Splitting reveals optional Address line 1 (e.g. 12 MG Road) and Address line 2 (e.g. Flat 4B, second floor). Merging displays both lines joined with a comma and remembers their split until the merged text is edited. Saving while merged stores all displayed text as line 1 and clears line 2; saving while split stores both fields separately. Either or both lines may be blank. Existing two-line bookmarks open split; legacy address text is treated entirely as line 1. Saved lines display together in the expanded tile, map Address Panel, and QR/export flows.

Local bookmarks have an info icon in the top-left corner. Clicking it shows storage and sync guidance in the bottom notification pill. Sync to cloud is in the three-dot menu. Sync is dimmed while signed out and opens sign-in when clicked; while signed in, it saves the bookmark to the cloud before removing the local copy.

Guide captions: the decode scanner and its parent stay above the guide overlay. Scan and Saved captions appear above their decode buttons; the map Saved caption appears below its bookmark button. Previous stays enabled during the guide even when city history is empty; its normal availability returns after dismissal. Static copyright footer text hides the browser caret without affecting input cursors.

The Map View scanner and search artwork use the primary accent (#69B7CF).

The profile artwork (default icon and signed-in avatar) is 42px with a padded tap target. Narrow Map View centers the bookmark and profile horizontally in the spaces beside the logo and vertically in the header. The logo fits between the reserved control spaces.

The label and Info modal logo groups share a 12px right offset with the centered main-page logo. The desktop main-page logo keeps a 10px gap from the right screen edge.

## Label modal

The Label modal also provides the optional Address split/merge control with line 1 and line 2 examples. Existing two-line addresses open split; toggling preserves boundaries until merged text is edited. Saving while merged stores the displayed text as line 1 and clears line 2. Preview, print, and image exports show only the address text, preserving split lines and excluding the editing controls and placeholder examples. Closing and reopening the label restores its address fields.

In both Saved and Label modals, the address split/merge icon appears only while the address editor or its toggle has keyboard focus. The icon sits at the bottom-right of the address line 1 field. Its gray lines stay the same in both states; only the filled primary-accent (#69B7CF) triangle changes direction, pointing down to split and up to merge.

Wide Map View uses a 42px by 42px bookmark container joined without a gap to the left edge of the search input.

Saved-address navigation and the info-window Address action use the same Address Panel renderer. Both preserve the separator between saved address lines and show the address QR button whenever the address has nonempty text. The QR payload retains both lines in order.

Scanner region inspection: hold the capture camera button for 500ms to show container, city, and three-word outlines; release hides them without capturing. A tap captures normally. The estimated rounded container encloses both the city and all three words, including city names wider than the code row.
