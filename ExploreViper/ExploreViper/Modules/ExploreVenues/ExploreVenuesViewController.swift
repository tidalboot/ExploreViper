//
//  ExploreVenuesViewController.swift
//  ExploreViper
//
//  Created by Georgios Aikaterinakis on 14/04/2019.
//  Copyright © 2019 Georgios Aikaterinakis. All rights reserved.
//

import Foundation
import UIKit

class ExploreVenuesViewController: UIViewController {
    
    var presenter: ViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
}

extension ExploreVenuesViewController: PresenterToViewProtocol {
    
    func loadVenues(venues: [Venue]) {
        
    }
    
    func noVenues() {

    }
    
    func showError() {
        
    }
}
