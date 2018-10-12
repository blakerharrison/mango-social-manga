//
//  TitleSearch + UISearchBar.swift
//  Mango (Social Manga)
//
//  Created by Blake Harrison on 8/29/18.
//  Copyright © 2018 Blake Harrison. All rights reserved.
//

import UIKit

let myFetchTitlesGroup = DispatchGroup()

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

        myFetchTitlesGroup.enter()

        self.searchBar.resignFirstResponder()

        MangoNetworking().fetchMangaTitles(searchedManga: self.searchBar.text!)

        activity.isHidden = false
        activityView.isHidden = false
        activity.startAnimating()
        
        myFetchTitlesGroup.notify(queue: DispatchQueue.main) {
            self.searchFilter(searchBar)
            
            self.activity.isHidden = true
            self.activityView.isHidden = true
            self.activity.stopAnimating()
        }
    }

    func searchFilter(_ searchBar: UISearchBar) {
//        resultsArray.removeAll()
//        filteredArray.removeAll(keepingCapacity: false)
//        let predicateString = searchBar.text!
//        filteredArray = resultsArray.filter( {$0.range(of: predicateString) != nil} )
//        resultsArray.sort {$0 < $1}
        isSearching = (resultsArray.count == 0) ? false: true
                            NotificationCenter.default.post(name: NSNotification.Name("finishedGettingTitles"), object: nil)
    }
}
