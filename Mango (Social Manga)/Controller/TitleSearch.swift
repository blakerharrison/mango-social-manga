//
//  TitleSearch.swift
//  Mango (Social Manga)
//
//  Created by Blake Harrison on 8/27/18.
//  Copyright © 2018 Blake Harrison. All rights reserved.
//

import UIKit

class TitleSearch: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: - Properties
    var isSearching: Bool = false
    var filteredArray: [String] = []
    
    //MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var activityView: UIView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchBar()
        self.searchBar.enablesReturnKeyAutomatically = true
        
        activity.isHidden = true
        activityView.isHidden = true
        
        navigationItem.title = "search"
        
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedStringKey.font: UIFont(name: "BigNoodleTitling", size: 21)!]
    }
    
    //MARK: - Methods
    private func setUpSearchBar() {
        searchBar.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching { return filteredArray.count }
        
        return filteredArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath)
        
        if isSearching {
            if let label = cell.viewWithTag(1000) as? UILabel {
                label.text = searchedMangaList[indexPath.row].t!
            }
        }

        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
        
        selectedIndex = indexPath.row
        selectedID = searchedMangaList[indexPath.row].i!
        
        // Segue to the second view controller
        self.performSegue(withIdentifier: "DetailSegue", sender: self)
    }
    
}
