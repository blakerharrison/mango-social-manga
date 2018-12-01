//
//  MangaClass.swift
//  Mango (Social Manga)
//
//  Created by Blake Harrison on 11/22/18.
//  Copyright © 2018 Blake Harrison. All rights reserved.
//

import Foundation
import SwiftyJSON

class MangaDataStructure {
    
    //MARK: Properties
    var mangaChapterIDs: [String] = []
    var currentChapterIndex = 0
    var currentChapterID = ""
    var mangaChaptersString: [String] = []
    var currentChapterString = ""
    
    //MARK: Methods
    func nextID() {
        guard mangaChapterIDs.isEmpty != true else {
            return
        }
        currentChapterIndex = currentChapterIndex + 1
        selectedIndex = selectedIndex + 1
        
        currentChapterID = mangaChapterIDs[currentChapterIndex]
        selectedChapterID = currentChapterID
        
        print(currentChapterID)
        print(selectedChapterID)
        

    }
    
    func addID(_ ID: String) {
        mangaChapterIDs.append(ID)
    }
    
    func removeIDs() {
        guard mangaChapterIDs.isEmpty != true else {
            return
        }
        mangaChapterIDs.removeAll()
    }
    
    func reverseIDs() {
        guard mangaChapterIDs.isEmpty != true else {
            return
        }
        mangaChapterIDs.reverse()
    }
    
    func removeChapterStrings() {
        guard mangaChaptersString.isEmpty != true else {
            return
        }
        mangaChaptersString.removeAll()
    }
    
    func changeChapterString(_ chapter: String) {
        currentChapterString = chapter
    }
}
