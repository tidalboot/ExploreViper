//
//  ExploreVenuesRouter.swift
//  ExploreViper
//
//  Created by Georgios Aikaterinakis on 14/04/2019.
//  Copyright © 2019 Georgios Aikaterinakis. All rights reserved.
//

import Foundation
import UIKit

class ExploreVenuesRouter: PresenterToRouterProtocol{
    
    class func createModule() -> UIViewController {
        let storyboard = UIStoryboard(name:"Main", bundle: Bundle.main)
        let view = storyboard.instantiateViewController(withIdentifier: "ExploreVenuesViewController") as? ExploreVenuesViewController
        
        let presenter: ViewToPresenterProtocol & InteractorToPresenterProtocol = ExploreVenuesPresenter()
        let interactor: PresenterToInteractorProtocol = ExploreVenuesInteractor()
        let router: PresenterToRouterProtocol = ExploreVenuesRouter()
        
        view?.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view!
    }
}
