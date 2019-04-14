//
//  ExploreViperUITests.swift
//  ExploreViperUITests
//
//  Created by Georgios Aikaterinakis on 14/04/2019.
//  Copyright © 2019 Georgios Aikaterinakis. All rights reserved.
//

import XCTest

class ExploreViperUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUp() {
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        
    }

    func testSearch() {
        // tap on the search bar to start editing
        let searchForVenuesInSearchField = app.searchFields["Search for venues in..."]
        searchForVenuesInSearchField.tap()
        
        let lKey = app/*@START_MENU_TOKEN@*/.keys["L"]/*[[".keyboards.keys[\"L\"]",".keys[\"L\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let oKey = app/*@START_MENU_TOKEN@*/.keys["o"]/*[[".keyboards.keys[\"o\"]",".keys[\"o\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let nKey = app.keys["n"]
        let dKey = app.keys["d"]
        
        // type 'London'
        lKey.tap()
        oKey.tap()
        nKey.tap()
        dKey.tap()
        oKey.tap()
        nKey.tap()
        
        // tap the 'Search' button
        let searchButton = app/*@START_MENU_TOKEN@*/.buttons["Search"]/*[[".keyboards.buttons[\"Search\"]",".buttons[\"Search\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        searchButton.tap()
        
        let delayExpectationVenuesFetched = expectation(description: "Waiting for venues to be fetched")
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            delayExpectationVenuesFetched.fulfill()
        }
        
        waitForExpectations(timeout: 5)
        XCTAssert(app.tables.staticTexts.count > 0, "expect some venues fetched")
        
        // tap on the search bar to start editing again
        searchForVenuesInSearchField.tap()
        
        // continue typing to have 'Londonnnn' i.e. something that produces no results
        nKey.tap()
        nKey.tap()
        nKey.tap()
        nKey.tap()
        
        // tap the 'Search' button
        searchButton.tap()
        
        let delayExpectationNoVenuesFetched = expectation(description: "Waiting for venues fetch to complete")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            delayExpectationNoVenuesFetched.fulfill()
        }
        
        waitForExpectations(timeout: 2)
        XCTAssert(app.tables.staticTexts.count == 0, "expect no venues fetched")
    }

}
