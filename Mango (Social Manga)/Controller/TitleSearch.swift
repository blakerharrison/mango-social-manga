//
//  TitleSearch.swift
//  Mango (Social Manga)
//
//  Created by Blake Harrison on 8/27/18.
//  Copyright © 2018 Blake Harrison. All rights reserved.
//

import UIKit

class TitleSearch: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let testArray = ["Bleach", "Naruto", "One Piece", "Green Worldz"]
    var filteredArray: [String] = []
    var isSearching: Bool = false
    
    //MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var table: UITableView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchBar()
    }
    
    //MARK: - Methods
    private func setUpSearchBar() {
        searchBar.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredArray.count
        }
        
        return testArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath)
        
        if isSearching {
            if let label = cell.viewWithTag(1000) as? UILabel {
                label.text = filteredArray[indexPath.row]
            }
        }

        return cell
    }
}

//MARK: - Extensions
extension TitleSearch: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isSearching = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
        searchFilter(searchBar)
        table?.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }
    
    fileprivate func searchFilter(_ searchBar: UISearchBar) {
        filteredArray.removeAll(keepingCapacity: false)
        let predicateString = searchBar.text!
        filteredArray = testArray.filter( {$0.range(of: predicateString) != nil} )
        filteredArray.sort {$0 < $1}
        isSearching = (filteredArray.count == 0) ? false: true
    }
    
}

