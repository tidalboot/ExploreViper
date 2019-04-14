//
//  ExploreVenuesInteractorTests.swift
//  ExploreViperTests
//
//  Created by Georgios Aikaterinakis on 14/04/2019.
//  Copyright © 2019 Georgios Aikaterinakis. All rights reserved.
//

import XCTest

@testable import ExploreViper

class ExploreVenuesInteractorTests: XCTestCase {
    
    var mockPresenter: MockExploreVenuesPresenter?
    var interactor: ExploreVenuesInteractor?
    
    override func setUp() {
        mockPresenter = MockExploreVenuesPresenter()
        interactor = ExploreVenuesInteractor()
        interactor?.presenter = mockPresenter
    }
    
    override func tearDown() {

    }
}
