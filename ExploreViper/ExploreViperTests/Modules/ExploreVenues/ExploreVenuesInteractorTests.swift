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
    
    func testParseExploreJSONResponse() {
        let resultsDictionary =
            ["response":
                ["groups":
                    [["items":
                        [["venue":
                            ["name": "name1"]
                            ],
                         ["venue":
                            ["name": "name2"]
                        ]]
                    ]]
                ]
            ]
        let noResultsDictionary = ["response": ["nothing" : []]]
        
        interactor?.parseExploreJSONResponse(responseDictionary: noResultsDictionary as NSDictionary)
        XCTAssert(mockPresenter?.noVenuesFetchedCalled == 1, "Expect noVenuesFetched called once")
        
        interactor?.parseExploreJSONResponse(responseDictionary: resultsDictionary as NSDictionary)
        XCTAssert(mockPresenter?.venuesFetchedCalled == 1, "Expect venuesFetched called once")
    }
}
