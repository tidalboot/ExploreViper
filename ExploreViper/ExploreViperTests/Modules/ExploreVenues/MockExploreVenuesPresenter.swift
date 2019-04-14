//
//  MockExploreVenuesPresenter.swift
//  ExploreViperTests
//
//  Created by Georgios Aikaterinakis on 14/04/2019.
//  Copyright © 2019 Georgios Aikaterinakis. All rights reserved.
//

import Foundation

@testable import ExploreViper

class MockExploreVenuesPresenter: ExploreVenuesPresenter {
    
    private(set) var text: String?
    private(set) var showVenuesCalled = 0
    private(set) var venuesFetchedCalled = 0
    private(set) var noVenuesFetchedCalled = 0
    private(set) var venuesFetchingFailedCalled = 0
    
    // MARK: ViewToPresenterProtocol methods
    
    override func showVenues(text: String) {
        self.text = text
        self.showVenuesCalled += 1
    }
    
    // MARK: InteractorToPresenterProtocol methods
    
    override func venuesFetched(venues: [Venue]) {
        venuesFetchedCalled += 1
    }
    
    override func noVenuesFetched() {
        noVenuesFetchedCalled += 1
    }
    
    override func venuesFetchingFailed() {
        venuesFetchingFailedCalled += 1
    }
}
