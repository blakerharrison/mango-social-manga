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
    
    //MARK: - Manga Details Method
    func saveMangaToFavorites(name: String, author: String, category: String, released: String, about: String, imageURL: String, status: String, id: String) {
        let addedManga = MangaDetailsRealm()
        
        addedManga.name = name
        addedManga.author = author
        addedManga.category = category
        addedManga.released = released
        addedManga.about = about
        addedManga.imageURL = imageURL
        addedManga.status = status
        addedManga.id = id
        
        try! realm.write {
            realm.add(addedManga)
        }
        
    }
    
    //MARK: - Viewed Chapter Methods
    func addViewedChapter(ID: String, chapterViewed: Bool) {
        guard chapterArray.isEmpty != true else {
            return
        }
        
        let chapters = realm.objects(MangaChapterPersistance.self).filter("chapterID = %@", ID)
        
        if let chapter = chapters.first {
            
            guard chapter.wasChapterViewed == true else {
                print("CHAPTER WAS VIEWED I FALSE")
                
                try! realm.write {
                    chapter.chapterID = ID
                    chapter.wasChapterViewed = true
                }
                
                return
            }

        } else {
            print("New item added to realm")
            try! self.realm.write {
                chapterPersistance.chapterID = ID
                chapterPersistance.wasChapterViewed = chapterViewed
                self.realm.add(chapterPersistance)
            }

        }

    }
    
    func removeViewedChapter(ID: String) {
        guard chapterArray.isEmpty != true else {
            return
        }
        
        let chapters = realm.objects(MangaChapterPersistance.self).filter("chapterID = %@", ID)
        
        if let chapter = chapters.first
        {
            //Check to see if ID already exists in Realm
            guard chapter.chapterID == ID else {
                print("ID does not exist")
                return
            }
            
            try! realm.write {
                chapter.chapterID = ID
                chapter.wasChapterViewed = false
            }
            
        }

    }
    
    func deleteEverything() {
        try! realm.write {
            realm.deleteAll()
        }
    }
}
