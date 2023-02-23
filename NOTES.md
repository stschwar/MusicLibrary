# Notes

Here are some additional notes regarding my implementation of the given task:

### Time constraint
I spent approx. 4h (give or take) on the main task and some additional optional tasks.


### Completed Tasks

#### Main:
- A music collection is fetched as JSON data from a remote server through the provided link
- The collection is displayed as a list and ordered alphabetically by album name
- The collection is searchable taking into account the album name, artist name &amp; tracks included with each album
- Only standard UI components have been used to accomplish the taks

#### Optional:
- Album cover images are loaded asynchronously/lazily
- The app provides 3 tabs that sort the collection in a different way.
- The search works across all tabs
- Reactive &amp; functional programming has been used


### Implementation notes:

- Central state and reactive state mutation have been realized with Swift Composable architecture
- The UI uses only SwiftUI components

- I chose `selectedTab` &amp; `searchTerm` as state as they are they are directly influenced by user input (UI driven state)
- The music collection `musicAlbums` is also state but remains mostly unmutated, it is either filled or empty
- The actual filtering &amp; sorting is done locally in the UI
- I considered that sorting & filtering locally in the UI is acually bad for the performance and could be remedied by putting pre-sorted collections as part of the state, as the sorting actually won't change (Just filtering the collection doesn't change the sortation)
- The list of sorted tracks in the third tab is just a list of strings. As such, searching for album name or artist name is not possible in this tab.
- I considered a Wrapper Type for Tracks, but dropped implementation in this case due to time constraints
- I considered diving deeper into features of the Swift Composable Architecture package, e.g. using scoped stores on the individiual lists, but due to the limited time &amp; lack of experience with the framework, I kept it simple.
- There is a UI bug where the list scrolls through the navigation bar when changing to another tab for the first time, it is not happening consistently and I tried some remedies, but nothing worked sufficiently.
I am not sure if this is an issues in SwiftUI or an error on my part, but I could not investigate further.


### Out-of-scope implementations

This happened after I sent in the assignment &amp; after the 4 hours passed:

- This document
- TBD