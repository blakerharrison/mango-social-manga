//
//  TitleSearch.swift
//  Mango (Social Manga)
//
//  Created by Blake Harrison on 8/27/18.
//  Copyright © 2018 Blake Harrison. All rights reserved.
//

import UIKit
import JGProgressHUD

class TitleSearch: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: - Properties
    var isSearching: Bool = false
    var filteredArray: [String] = []
    let hud = JGProgressHUD(style: .extraLight)
    
    let networking = MangoNetworking()
    
    //MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var activityView: UIView!
    @IBOutlet weak var noTitleFoundImage: UIImageView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(refreshTable(notification:)), name: NSNotification.Name(rawValue: "finishedGettingTitles"), object: nil)
        
        setUpSearchBar()
        self.searchBar.enablesReturnKeyAutomatically = true

        navigationItem.title = "Search"
        
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.font: UIFont(name: Fonts.Knockout.rawValue, size: 21)!]
        
        activity.isHidden = true
        activityView.isHidden = true
        
        searchBar.becomeFirstResponder()
        
        searchBar.backgroundImage = UIImage()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        mangaDataStructure.removeChapterStrings()
        mangaDataStructure.resetToDefault()
        
        NotificationCenter.default.post(name: .MangaDetailWasExited, object: nil)
        chaptersArray.removeAll()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    //MARK: - Methods
    private func setUpSearchBar() {
        searchBar.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            print("Currently Searching...")
            
            noTitleFoundImage.isHidden = true
            table.isHidden = false
            
            return resultsArray.count
        }
        return resultsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath)
        if isSearching {
                if let label = cell.viewWithTag(1000) as? UILabel {
                    label.text = resultsArray[indexPath.row].replacingOccurrences(of: "%27", with: "'", options: .literal, range: nil)
                }
        }
        return cell
    }
    
    @objc func refreshTable(notification: NSNotification) {
        DispatchQueue.main.async {
            self.table.layoutIfNeeded()
            self.table.reloadData()
            self.table.contentOffset = CGPoint(x: 0, y: -self.table.contentInset.top)
            
            self.activity.isHidden = true
            self.activityView.isHidden = true
            self.activity.stopAnimating()
            
            self.hud.dismiss(animated: false)
            
            if resultsArray.count == 0 && self.isSearching == false {
                self.noTitleFoundImage.isHidden = false
                self.table.isHidden = true
            }
            
        }
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
