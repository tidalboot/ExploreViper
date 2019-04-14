//
//  MockExploreVenuesViewController.swift
//  ExploreViperTests
//
//  Created by Georgios Aikaterinakis on 14/04/2019.
//  Copyright © 2019 Georgios Aikaterinakis. All rights reserved.
//

import Foundation

@testable import ExploreViper

class MockExploreVenuesViewController: ExploreVenuesViewController {
    
    private(set) var loadVenuesCalled = 0
    private(set) var noVenuesCalled = 0
    private(set) var showErrorCalled = 0
    private(set) var mockVenues : [Venue] = []
    
    override func loadVenues(venues: [Venue]) {
        mockVenues = venues
        loadVenuesCalled += 1
    }
    
    override func noVenues() {
        noVenuesCalled += 1
    }
    
    override func showError() {
        self.showErrorCalled += 1
    }
}
