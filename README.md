# ReadDen

ReadDen is an app for book club administrators/hosts to organize books and meetings.
In the current version, a user can search for books, add or remove specific books to a 'Read' shelf, and rate added books. The user can also create/remove book club meetings.

## Instructions

To use this app, you will need to:
1. Request the developer for a 'Books-Info.plist' file that contains the API key
2. Clone the repository
3. Open the file ReadDen.xcodeproj with Xcode
4. Run the project

## Features and Navigation
1. On launching the app for the first time, the user is greeted with an onboarding screen. Click 'Start'.
2. The app is organized into 4 tabs - 'Find', 'Read Books', 'Meetings', and 'Settings'.
3. 'Find' is the default tab the user sees. This loads a scrollable list of 15 books referencing 'Barbara Kingsolver'. A user can click on any item to see the book details. The user can enter any search criteria in the 'search for books' field and hit enter to find more books.
4. In the book details screen, the user can view info about the title. The button 'Add to Books We've Read' will send entries to the 'Read Books' tab. The same title cannot be added twice.
5. 'Read Books' tab is empty at launch. Books can be added by the steps described above. Added books have an empty rating by default, allowing the admin to provide the book club's rating. Books can be removed with a left swipe.
6. 'Meetings' tab lists past and upcoming meetings (sorted by latest). Two meetings are present by default. To remove a meeting, swipe left on the item. To add meetings, click on the + symbol on the top right of the screen.
7. The 'Add new meeting' sheet allows a user to enter the meeting title, the book title, choose a future date and select the number of attendees to create a new meeting. More than one meeting cannot be added for the same date.
8. The 'Settings' tab allows a user to choose their default setting to keep dark mode on or off. This setting is persisted for future launches. There is a temporary setting allowing the user to launch onboarding screen again.

## Grading Rubric details
1. The static launch screen is stored in 'Launch Screen' storyboard.
2. The tabs are written in /Views/ContentTabView.swift
3. List with clickable elements is present in /Views/BookListView.swift. Clicking an item leads to a details view in /Views/BookView.swift. Images are downloaded using AsyncImage with a progressive attached.
4. URLSession network call is made in /Models/BooksStore.swift
5. The Books-Info.plist' with API key will be shared.
6. The app uses Google's Books API which has a limit of 1000 calls per day.
7. The app uses user defaults to save data - the user's preferred dark mode setting, selected in the /Views/SettingsView.swift and used in /Views/ContentTabView.swift
8. Async/Await and MainActor are used in /Models/BooksStore.swift and referenced by view /Views/BookListView.swift. 'BooksStore' has an initializer with search string 'Barbara Kingsolver'. 'BookListView' is where the user triggered search is initiated.
9. The app shows a 'no data available' message corresponding to the screen when all items are removed from list or there is an error in search/network calls.
10. Wrappers'ObservableObject' and 'Published' are used in models /Models/BooksStore.swift, /Models/MeetingStore.swift and /Models/ReadBookStore.swift. File /Views/ContentView.swift uses 'StateObject' and several views reference them with 'ObservedObject' wrapper.
11. SwiftLint is included in build phases. No errors or warnings are generation on building the project.
12. The project contains a unit testing plan 'ReadDenTests' and a UI testing plan 'ReadDenUITests'. The most recent reported coverage was ~83%.
13. The custom icon is included as 'logo' in Assets. The onboarding screen uses /Views/OnBoardingView.swift and /Views/StartButtonView.swift. 
14. Animation is included in /Views/OnBoardingView.swift
