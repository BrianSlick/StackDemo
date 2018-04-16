# StackDemo

-----

Behaviors to note:

* Thumbnails are observed to download pretty quickly. Challenge guidelines require loading indicators. In order to more easily observe these in action (and demonstrate app responsiveness), a sleep call has been inserted to simulate a longer download time. This has been marked with a `#warning`, the only warning that currently exists in the project. Change the sleep time as desired, or comment it out to see app at full speed.
* The app saves downloaded images, per challenge guidelines. In order to observe changes to the sleep call, it is easiest to delete the app from the simulator/device and start fresh.
* The refresh button will dump all user data and re-download, but images are not deleted. The table view will clear and repopulate to reflect the data change, but activity indicators are not expected since the images have already been downloaded (unless there are new users, but observations are that this list of users doesn't really change much).

----

Design Comments:

* **BSStackOverflowAPIVendor** - The purpose of this class is to generate the URLs that are consumed throughout the app. Demo app only uses one endpoint, but any additional primary endpoints, or any sub-endpoints that need parameter data (ex: detailsForUser:[UserID]), would be defined here. URLs are constructed dynamically to facilitate easier changes in the future (Ex: API version only has to be changed in one place).
* **BSStackOverflowJSONHelper** - This is basically the data structure companion to the API vendor class. It provides helper methods to convert the downloaded JSON into native objects. This should be the one-stop-shop for data structure knowledge, with plenty of links to any available API documentation. Ideally no JSON keys are used outside of this class.
* **Singletons** - Although controversial in some circles, there are plenty of examples where it just makes sense to use singletons for single-purpose classes. Core Data stuff doesn't need to be spread around, so a single class manages the stack (and gets it out of the AppDelegate where Apple's template places it), and is easily reused in other projects. Networking is also single-purpose, with all calls being routed to the same place. The user and image data managers are style choices; they could easily be combined into a single data manager. It is arguably a bit cleaner to separate them, with a clear delineation of duties. The important part to all of these classes is that the functionality does not reside in a view controller. Anybody that needs to can trigger a download, for example.