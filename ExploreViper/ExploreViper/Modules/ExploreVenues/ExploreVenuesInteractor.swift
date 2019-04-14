//
//  ExploreVenuesInteractor.swift
//  ExploreViper
//
//  Created by Georgios Aikaterinakis on 14/04/2019.
//  Copyright © 2019 Georgios Aikaterinakis. All rights reserved.
//

import Foundation

class ExploreVenuesInteractor: PresenterToInteractorProtocol {
    
    var presenter: InteractorToPresenterProtocol?
    
    // keys provided by FourSquare API
    var CLIENT_ID = "255FDQOTQE1LNCQCVQSBR424OJ2Q04DFJU1H32DSL5F4V3PP"
    var CLIENT_SECRET = "K2JWWI3D3IT55GGGDZ2VX2M0YUXCHLN5KKCTGCIOPMIL32W5"
    var versionDate = "20190414"
    
    func generateURL(searchString: String) -> URL {
        // encode string for url, in case it includes spaces, slashes, etc.
        let searchStringURLEncoded = searchString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let urlString : String = "https://api.foursquare.com/v2/venues/explore?client_id=" + CLIENT_ID + "&client_secret=" + CLIENT_SECRET + "&v=" + versionDate + "&near=" + searchStringURLEncoded
        let url : URL = URL(string: urlString)!
        
        return url
    }
    
    func parseVenuesArray(venuesArray: Array<[String: Any]>) -> Array<Venue> {
        let venueObjectsArray : NSMutableArray = []
        for venueDictionary in venuesArray {
            venueObjectsArray.add(Venue.init(dictionary: venueDictionary))
        }
        
        return venueObjectsArray as! Array<Venue>
    }
    
    func parseExploreJSONResponse(responseDictionary: NSDictionary) {
        // check if the json is formed as expected for a response with results
        guard let responseGroups = (responseDictionary["response"] as! [String: Any])["groups"] as? NSArray else {
            // no results found
            self.presenter?.noVenuesFetched()
            return
        }
        
        // extract the array of venues and transform it to an array of Venue objects
        let venuesArray = (responseGroups[0] as! [String: Any])["items"] as! Array<[String: Any]>
        let venues = self.parseVenuesArray(venuesArray: venuesArray)
        
        // pass the Venue objects array to the presenter
        self.presenter?.venuesFetched(venues: venues)
    }
    
    func fetchVenues(searchString: String) {
        let url : URL = self.generateURL(searchString: searchString)
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error == nil {
                do {
                    let decodedJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary
                    self.parseExploreJSONResponse(responseDictionary: decodedJSON)
                } catch {
                    self.presenter?.venuesFetchingFailed()
                }
            } else {
                self.presenter?.venuesFetchingFailed()
            }
        }
        task.resume()
    }
}
