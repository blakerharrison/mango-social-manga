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
    
    //MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath)
        
        if let label = cell.viewWithTag(1000) as? UILabel {
            label.text = testArray[indexPath.row]
        }
        
        return cell
    }

}


