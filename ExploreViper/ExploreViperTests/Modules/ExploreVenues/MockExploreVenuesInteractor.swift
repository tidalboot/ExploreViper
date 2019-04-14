//
//  MockExploreVenuesInteractor.swift
//  ExploreViperTests
//
//  Created by Georgios Aikaterinakis on 14/04/2019.
//  Copyright © 2019 Georgios Aikaterinakis. All rights reserved.
//

import Foundation

@testable import ExploreViper

class MockExploreVenuesInteractor : ExploreVenuesInteractor {
    
    private(set) var searchString: String?
    private(set) var fetchVenuesCalled = 0
    
    override func fetchVenues(searchString: String) {
        self.searchString = searchString
        self.fetchVenuesCalled += 1
    }
}
