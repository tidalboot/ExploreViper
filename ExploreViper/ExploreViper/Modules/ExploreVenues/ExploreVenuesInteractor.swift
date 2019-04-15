//
//  ExploreVenuesInteractor.swift
//  ExploreViper
//
//  Created by Georgios Aikaterinakis on 14/04/2019.
//  Copyright © 2019 Georgios Aikaterinakis. All rights reserved.
//

import Foundation

class ExploreVenuesInteractor {

    var presenter: InteractorToPresenterProtocol?
    var venues: [Venue]?
    private var _viewModel: InteractorViewModel?

    // keys provided by FourSquare API
    var CLIENT_ID = "255FDQOTQE1LNCQCVQSBR424OJ2Q04DFJU1H32DSL5F4V3PP"
    var CLIENT_SECRET = "K2JWWI3D3IT55GGGDZ2VX2M0YUXCHLN5KKCTGCIOPMIL32W5"
    var versionDate = "20190414"

    //NEW
    func generateURL(searchString: String) -> URL? {
        // encode string for url, in case it includes spaces, slashes, etc.
        guard let searchStringURLEncoded = searchString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return nil }

        let urlString : String = "https://api.foursquare.com/v2/venues/explore?client_id=" + CLIENT_ID + "&client_secret=" + CLIENT_SECRET + "&v=" + versionDate + "&near=" + searchStringURLEncoded

        guard let url = URL(string: urlString) else { return nil }

        return url
    }

    private struct InteractorViewModel: ExploreVenuesViewModel {
        var numberOfVenues: Int
        var names: [String]
    }
}

extension ExploreVenuesInteractor: PresenterToInteractorProtocol {

    var viewModel: ExploreVenuesViewModel? {
        return _viewModel
    }

    func parseVenuesArray(venuesArray: [[String: Any]]?) -> [Venue] {

        return venuesArray?.compactMap( { Venue(dictionary: $0) } ) ?? [Venue]()
    }

    func parseExploreJSONResponse(responseDictionary: [String: Any]?) -> [Venue]? {

        guard let responseDictionary = responseDictionary,
            let response = responseDictionary["response"] as? [String: Any],
            let responseGroups = response["groups"] as? [[String: Any]] else {

            presenter?.noVenuesFetched()
            return nil
        }

        let responseItems = responseGroups.compactMap( { $0["items"] as? [[String: Any]] } )

        let venues: [Venue] = responseItems.compactMap( { parseVenuesArray(venuesArray: $0) } ).reduce([Venue](), +)

        return venues
    }


    func fetchVenues(searchString: String) {

        guard let url : URL = generateURL(searchString: searchString) else { return }

        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in

            guard error == nil else {
                self.presenter?.venuesFetchingFailed()
                return
            }

            guard let decodedJSON = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String: Any] else {
                self.presenter?.venuesFetchingFailed()
                return
            }

            guard let decodedVenues = self.parseExploreJSONResponse(responseDictionary: decodedJSON) else {
                self.presenter?.venuesFetchingFailed()
                return
            }

            if decodedVenues.isEmpty {
                self.presenter?.noVenuesFetched()
                return
            }

            self.venues = decodedVenues

            self._viewModel = InteractorViewModel(numberOfVenues: decodedVenues.count, names: decodedVenues.map( { $0.name } ))
            self.presenter?.venuesFetched()
        }
        task.resume()
    }
}
