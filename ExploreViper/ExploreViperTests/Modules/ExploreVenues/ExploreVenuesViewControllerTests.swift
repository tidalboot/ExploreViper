//
//  ExploreVenuesViewControllerTests.swift
//  ExploreViperTests
//
//  Created by Georgios Aikaterinakis on 14/04/2019.
//  Copyright © 2019 Georgios Aikaterinakis. All rights reserved.
//

import XCTest

@testable import ExploreViper

class ExploreVenuesViewControllerTests: XCTestCase {
    
    var mockPresenter: MockExploreVenuesPresenter?
    var view: ExploreVenuesViewController?
    
    override func setUp() {
        mockPresenter = MockExploreVenuesPresenter()
        
        let storyboard = UIStoryboard(name:"Main", bundle: Bundle.main)
        view = storyboard.instantiateViewController(withIdentifier: "ExploreVenuesViewController") as? ExploreVenuesViewController
        view?.loadView()
        view?.presenter = mockPresenter
    }
    
    override func tearDown() {
        
    }
    
    func testSearchTapped() {
        view?.searchBar.text = "Huntingdon"
        
        view?.searchBarSearchButtonClicked((view?.searchBar)!)
        
        XCTAssert(mockPresenter?.showVenuesCalled == 1,
                  "Expect showVenuesCalled called once")
        XCTAssert(mockPresenter?.text != nil,
                  "Expect text is not null")
        XCTAssert(mockPresenter?.text == "Huntingdon",
                  "Expect search text is 'Huntingdon'")
    }
}
