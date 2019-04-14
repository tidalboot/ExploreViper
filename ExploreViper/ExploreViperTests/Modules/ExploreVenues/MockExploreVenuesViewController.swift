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
    
    private(set) var showErrorCalled = 0
    
    override func showError() {
        self.showErrorCalled += 1
    }
}
