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
    var viewModel: ExploreVenuesViewModel?

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self

        // stops creating empty rows
        tableView.tableFooterView = UIView.init(frame: CGRect.zero)
    }

    func dataAreLoading() {

        let spinningView = UIView.init(frame: tableView.frame)
        let spinningWheel = UIActivityIndicatorView.init(frame: CGRect.init(x: spinningView.frame.size.width/2 - 25, y: spinningView.frame.size.height/2, width: 50, height: 50))
        spinningWheel.color = UIColor.gray
        spinningView.addSubview(spinningWheel)
        spinningWheel.startAnimating();
        tableView.backgroundView = spinningView;
        tableView.reloadData();
    }
}

extension ExploreVenuesViewController: PresenterToViewProtocol {
    
    func showNoResultsView() {
        let emptyView = UIView.init(frame: tableView.frame)
        let emptyMessage = UILabel.init(frame: CGRect.init(x: 0, y: 40, width: 100, height: 200))
        
        emptyMessage.text = "No venues found for \"" + (searchBar.text ?? "") + "\""
        // TODO: convert to multiple lines so that it fits the screen whatever the text
        emptyMessage.sizeToFit()
        emptyMessage.frame = CGRect.init(x: emptyView.frame.size.width/2 - emptyMessage.frame.size.width/2,
                                         y: 100,
                                         width: emptyMessage.frame.size.width,
                                         height: emptyMessage.frame.size.height)
        
        emptyView.addSubview(emptyMessage)
        tableView.backgroundView = emptyView
    }
    
    func update() {
        DispatchQueue.main.async {
            self.tableView.backgroundView = nil;
            self.tableView.reloadData()
        }
    }

    func updateViewModel(with viewModel: ExploreVenuesViewModel) {
        self.viewModel = viewModel
        update()
    }

    func noVenues() {
        update()
    }
    
    func showError() {
        update()

        let alert = UIAlertController(title: "Error", message: "Oops! Something went wrong... please check your connection or try again later", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        present(alert, animated: true, completion: nil)
    }
}

extension ExploreVenuesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCellId") else { return UITableViewCell() }

        cell.textLabel?.text = viewModel?.names[indexPath.row]

        return cell
    }
}

extension ExploreVenuesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfVenues ?? 0
    }
}

extension ExploreVenuesViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let text : String = searchBar.text ?? ""

        if text.count > 0 {

            presenter?.showVenues(text: text)
            searchBarCancelButtonClicked(searchBar)
        }
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
}

