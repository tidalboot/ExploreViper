# ExploreViper

An iOS app that accepts a place name and shows a list of nearby venues. This is achieved by integrating the FourSquare API, which provides recommended venues near the given place name.

This is my first attempt on the VIPER design pattern and here are the steps that I followed:
* Created a 'Single View App' project on Xcode.
* Created the Viper classes: View, Interactor, Presenter, Entity, Router and their protocols for my module 'ExploreVenues' which is the only screen.
* Decided what protocol methods will be needed for each class and implemented just those at this point, setting up the VIPER classes communication and the creation of the module.
* Added the UI to the view, connected it to the view controller and implemented the required methods for the search bar and table view.
* All the boilerplate code plus the UI is ready, so next I started setting up unit tests by creating mock classes for the VIPER classes.
* Added unit tests about the VIPER classes communication.
* Worked on the Interactor to integrate with the FourSquare API.
* At this point the app is working, so I started dealing with some details and improving the UI, mainly to indicate to the user when the app is fetching/loading or what was the result of the search.
* Finally, I added some UI tests for the basic functionality of this view.

This is a very basic app at this point. My next steps would be to:
* Create a custom table view cell that shows more of the venue data that the FourSquare API provides e.g. category names, distance from my position (CLLocation).
* Add a detail view to show all the venue details e.g. address, photos (if provided), categories (and their details).
* Add a map view that puts the results on the map, calculate and draw a route to the selected place.
* Make more use of the FourSquare API; the next thing could be to use the 'suggestcompletion' endpoint while typing in the search bar.
