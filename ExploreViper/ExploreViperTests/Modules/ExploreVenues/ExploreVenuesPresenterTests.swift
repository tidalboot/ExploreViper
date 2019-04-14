//
//  ExploreVenuesPresenterTests.swift
//  ExploreViperTests
//
//  Created by Georgios Aikaterinakis on 14/04/2019.
//  Copyright © 2019 Georgios Aikaterinakis. All rights reserved.
//

import XCTest

@testable import ExploreViper

class ExploreVenuesPresenterTests: XCTestCase {
    
    var mockRouter: MockExploreVenuesRouter?
    var mockView: MockExploreVenuesViewController?
    var mockInteractor: MockExploreVenuesInteractor?
    var presenter: ExploreVenuesPresenter?
    
    let searchText: String = "Huntingdon"
    
    override func setUp() {
        mockView = MockExploreVenuesViewController()
        mockRouter = MockExploreVenuesRouter()
        mockInteractor = MockExploreVenuesInteractor()
        
        presenter = ExploreVenuesPresenter()
        presenter?.view = mockView
        presenter?.router = mockRouter
        presenter?.interactor = mockInteractor
    }
    
    override func tearDown() {

    }
    
    func testShowVenues() {        
        presenter?.showVenues(text: "Huntingdon")
        
        XCTAssert(mockInteractor?.fetchVenuesCalled == 1, "Expect showVenues called once")
        XCTAssert(mockInteractor?.searchString == "Huntingdon",
                  "Expect searchString 'Huntingdon'")
    }
    
    func testVenuesFetched() {
        presenter?.venuesFetched(venues: [])
        
        XCTAssert(mockView?.loadVenuesCalled == 1, "Expect venuesFetched called once")
        XCTAssert(mockView?.mockVenues.count == 0, "Expect the same array of venues")
        
        let venue1 : Venue = Venue.init()
        venue1.name = "name1"
        let venue2 : Venue = Venue.init()
        venue2.name = "name2"
        
        presenter?.venuesFetched(venues: [venue1, venue2])
        
        XCTAssert(mockView?.loadVenuesCalled == 2, "Expect venuesFetched called a second time")
        XCTAssert(mockView?.mockVenues.count == 2, "Expect the same array of venues")
        
    }
    
    func testNoVenuesFetched() {
        presenter?.noVenuesFetched()
        
        XCTAssert(mockView?.noVenuesCalled == 1, "Expect noVenuesFetched called once")
        XCTAssert(mockView?.mockVenues.count == 0, "Expect no venues")
    }
    
    func testVenuesFetchingFailed() {
        presenter?.venuesFetchingFailed()
        
        XCTAssert(mockView?.showErrorCalled == 1, "Expect venuesFetchingFailed called once")
        XCTAssert(mockView?.mockVenues.count == 0, "Expect no venues")
    }
}
