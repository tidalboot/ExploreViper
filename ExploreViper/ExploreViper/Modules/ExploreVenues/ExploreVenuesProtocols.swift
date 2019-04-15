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
    func updateViewModel(with viewModel: ExploreVenuesViewModel)
    func noVenues()
    func showError()
}

protocol ExploreVenuesViewModel {
    var numberOfVenues: Int { get }
    var names: [String] { get }
}

protocol InteractorToPresenterProtocol: class {
    func venuesFetched()
    func noVenuesFetched()
    func venuesFetchingFailed()
}

protocol PresenterToInteractorProtocol: class {

    var viewModel: ExploreVenuesViewModel? { get }
    var presenter: InteractorToPresenterProtocol? { get set }

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
