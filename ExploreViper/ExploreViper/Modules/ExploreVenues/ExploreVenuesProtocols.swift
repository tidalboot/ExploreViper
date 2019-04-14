//
//  ExploreVenuesProtocols.swift
//  ExploreViper
//
//  Created by Georgios Aikaterinakis on 14/04/2019.
//  Copyright © 2019 Georgios Aikaterinakis. All rights reserved.
//

import Foundation
import UIKit

protocol PresenterToViewProtocol: class {
    func loadVenues(venues: [Venue])
    func noVenues()
    func showError()
}

protocol InteractorToPresenterProtocol: class {
    func venuesFetched(venues: [Venue])
    func noVenuesFetched()
    func venuesFetchingFailed()
}

protocol PresenterToInteractorProtocol: class {
    var presenter: InteractorToPresenterProtocol? {get set}
    func fetchVenues(searchString: String)
}

protocol ViewToPresenterProtocol: class {
    var view: PresenterToViewProtocol? {get set}
    var interactor: PresenterToInteractorProtocol? {get set}
    var router: PresenterToRouterProtocol? {get set}
    func showVenues(text: String)
}

protocol PresenterToRouterProtocol: class {
    static func createModule() -> UIViewController
}
