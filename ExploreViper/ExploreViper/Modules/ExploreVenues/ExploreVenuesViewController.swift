//
//  ExploreVenuesViewController.swift
//  ExploreViper
//
//  Created by Georgios Aikaterinakis on 14/04/2019.
//  Copyright © 2019 Georgios Aikaterinakis. All rights reserved.
//

import Foundation
import UIKit

class ExploreVenuesViewController: UIViewController, PresenterToViewProtocol, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var presenter: ViewToPresenterProtocol?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var venues : [Venue] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBar.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // stops creating empty rows
        self.tableView.tableFooterView = UIView.init(frame: CGRect.zero)
    }
    
    // MARK: PresenterToViewProtocol methods
    
    func loadVenues(venues: [Venue]) {
        DispatchQueue.main.async {
            self.venues = venues
            self.tableView.reloadData()
        }
    }
    
    func noVenues() {
        DispatchQueue.main.async {
            self.venues = []
            self.tableView.reloadData()
        }
    }
    
    func showError() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: "Oops! Something went wrong... please check your connection or try again later", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: search bar methods
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let text : String = searchBar.text ?? ""
        
        if text.count > 0 {
            self.presenter?.showVenues(text: text)
            self.searchBarCancelButtonClicked(self.searchBar)
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    
    // MARK: tableView delegate methods
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venues.count
    }
    
    // MARK: tableView dataSource methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "SearchResultCellId")
        
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "SearchResultCellId")
        }
        cell!.textLabel?.text = self.venues[indexPath.row].name
        
        return cell!
    }
}
