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
    
    func dataAreLoading() {
        venues = [];
        let spinningView = UIView.init(frame: self.tableView.frame)
        let spinningWheel = UIActivityIndicatorView.init(frame: CGRect.init(x: spinningView.frame.size.width/2 - 25, y: spinningView.frame.size.height/2, width: 50, height: 50))
        spinningWheel.color = UIColor.gray
        spinningView.addSubview(spinningWheel)
        spinningWheel.startAnimating();
        self.tableView.backgroundView = spinningView;
        self.tableView.reloadData();
    }
    
    func showNoResultsView() {
        let emptyView = UIView.init(frame: tableView.frame)
        let emptyMessage = UILabel.init(frame: CGRect.init(x: 0, y: 40, width: 100, height: 200))
        
        emptyMessage.text = "No venues found for \"" + (self.searchBar.text ?? "") + "\""
        // TODO: convert to multiple lines so that it fits the screen whatever the text
        emptyMessage.sizeToFit()
        emptyMessage.frame = CGRect.init(x: emptyView.frame.size.width/2 - emptyMessage.frame.size.width/2,
                                         y: 100,
                                         width: emptyMessage.frame.size.width,
                                         height: emptyMessage.frame.size.height)
        
        emptyView.addSubview(emptyMessage)
        tableView.backgroundView = emptyView
    }
    
    func dataFinishedLoading() {
        tableView.backgroundView = nil;
        
        if (self.venues.count == 0) {
            self.showNoResultsView()
        }
        
        self.tableView.reloadData()
    }
    
    // MARK: PresenterToViewProtocol methods
    
    func loadVenues(venues: [Venue]) {
        DispatchQueue.main.async {
            self.venues = venues
            self.dataFinishedLoading()
        }
    }
    
    func noVenues() {
        DispatchQueue.main.async {
            self.dataFinishedLoading()
        }
    }
    
    func showError() {
        DispatchQueue.main.async {
            self.dataFinishedLoading()
            
            let alert = UIAlertController(title: "Error", message: "Oops! Something went wrong... please check your connection or try again later", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: search bar methods
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let text : String = searchBar.text ?? ""
        
        if text.count > 0 {
            self.dataAreLoading()
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
