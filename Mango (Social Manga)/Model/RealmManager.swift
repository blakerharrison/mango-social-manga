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
        
        let chapters = realm.objects(MangaChapterPersistance.self).filter("chapterID = %@", ID)
        
        if let chapter = chapters.first
        {
            try! realm.write {
                chapter.chapterID = ID
                chapter.wasChapterViewed = chapterViewed
            }
//            print(realm.objects(MangaChapterPersistance.self).first!) //Prints the object
        }

        try! self.realm.write {
            chapterPersistance.chapterID = ID
            chapterPersistance.wasChapterViewed = chapterViewed
            self.realm.add(chapterPersistance)
        }
    }
    
    func deleteEverything() {
        try! realm.write {
            realm.deleteAll()
        }
    }
}
