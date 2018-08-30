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
    let testArray = ["Bleach", "Naruto", "One Piece", "Green Worldz"] //TODO: Will be populated by DB.
    var filteredArray: [String] = []
    
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
        if isSearching { return filteredArray.count }
        
        return filteredArray.count
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
