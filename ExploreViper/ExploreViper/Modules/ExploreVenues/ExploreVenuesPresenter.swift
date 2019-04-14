//
//  ExploreVenuesPresenter.swift
//  ExploreViper
//
//  Created by Georgios Aikaterinakis on 14/04/2019.
//  Copyright © 2019 Georgios Aikaterinakis. All rights reserved.
//

import Foundation

class ExploreVenuesPresenter: ViewToPresenterProtocol, InteractorToPresenterProtocol {
    
    var view: PresenterToViewProtocol?
    var interactor: PresenterToInteractorProtocol?
    var router: PresenterToRouterProtocol?
    
    // MARK: ViewToPresenterProtocol methods
    
    func showVenues(text: String) {
        self.interactor?.fetchVenues(searchString: text)
    }
    
    // MARK: InteractorToPresenterProtocol methods
    
    func venuesFetched(venues: [Venue]) {
        self.view?.loadVenues(venues: venues);
    }
    
    func noVenuesFetched() {
        self.view?.noVenues()
    }
    
    func venuesFetchingFailed() {
        self.view?.showError()
    }
}
