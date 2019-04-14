//
//  ExploreVenuesModel.swift
//  ExploreViper
//
//  Created by Georgios Aikaterinakis on 14/04/2019.
//  Copyright © 2019 Georgios Aikaterinakis. All rights reserved.
//

import Foundation

class Venue {
    
    var name: String

    init() {
        self.name = ""
    }
    
    // extract the values we need from the json dictionary
    init(dictionary: [String: Any]) {
        self.name = (dictionary["venue"] as! NSDictionary)["name"] as! String
    }
}
