//
//  TitleSearch + UISearchBar.swift
//  Mango (Social Manga)
//
//  Created by Blake Harrison on 8/29/18.
//  Copyright © 2018 Blake Harrison. All rights reserved.
//

import UIKit

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
        print("")
        print(self.searchBar.text!)
        print("")
        
        self.searchBar.resignFirstResponder()
//        MangoNetworking().fetchJSON(search: self.searchBar.text!)
        MangoNetworking().fetchMangaTitles(searchedManga: self.searchBar.text!)

//        activity.isHidden = false
//        activityView.isHidden = false
//
//        activity.startAnimating()
        
        sleep(5) //TODO: Change with Dispatch Queue
        
//        activity.isHidden = true
//        activityView.isHidden = true
//        
//        activity.stopAnimating()
        
        searchFilter(searchBar)
        table?.reloadData()
        activity.startAnimating()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }
    
    func searchFilter(_ searchBar: UISearchBar) {
        filteredArray.removeAll(keepingCapacity: false)
        let predicateString = searchBar.text!
        filteredArray = resultsArray.filter( {$0.range(of: predicateString) != nil} )
        filteredArray.sort {$0 < $1}
        isSearching = (filteredArray.count == 0) ? false: true
    }
}
