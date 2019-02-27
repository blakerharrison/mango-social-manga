//
//  RealmManager.swift
//  Mango (Social Manga)
//
//  Created by Blake Harrison on 2/26/19.
//  Copyright © 2019 Blake Harrison. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {
    
    //MARK: Properties
    let realm = try! Realm()
    let chapterPersistance = MangaChapterPersistance()
    
    //MARK: Methods
    func printFilePath() {
        print(Realm.Configuration.defaultConfiguration.fileURL ?? "No path found.")
    }
    
    func addViewedChapter(ID: String, chapterViewed: Bool) {
        guard chapterArray.isEmpty != true else {
            return
        }
        
        chapterPersistance.chapterID = ID
        chapterPersistance.wasChapterViewed = chapterViewed
        
        try! self.realm.write {
            self.realm.add(chapterPersistance)
        }
    }
}
