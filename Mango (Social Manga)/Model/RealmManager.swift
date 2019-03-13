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
    func saveMangaToFavorites(name: String, author: String, category: String, released: String, about: String, imageURL: String, status: String, id: String, order: Int) {

        let addedManga = MangaDetailsRealm()
        
        addedManga.name = name
        addedManga.author = author
        addedManga.category = category
        addedManga.released = released
        addedManga.about = about
        addedManga.imageURL = imageURL
        addedManga.status = status
        addedManga.id = id
        addedManga.order = order
        
        try! realm.write {
            realm.add(addedManga)
        }
    }

    func readFavoritedMangas() {
        if realm.objects(MangaDetailsRealm.self).count > 0 {
            
            favoritedManga.removeAll()
            
            for i in 0..<realm.objects(MangaDetailsRealm.self).count {
                favoritedManga.append(realm.objects(MangaDetailsRealm.self)[i])
            }
            
            favoritedManga.sort { $0.order < $1.order }
            
        } else {
            print("There's no data.")
        }
    }
    
    func deleteFavoritedManga(id: String) {
        let mangas = realm.objects(MangaDetailsRealm.self).filter("id = %@", id)
        
        if let manga = mangas.first {
            
            guard manga.id == id else {
                print("ID does not exist")
                return
            }
            
            try! realm.write {
                realm.delete(manga)
            }
        }
    }
    
    //MARK: - Viewed Chapter Methods
    func addViewedChapter(chapterTitle: String, ID: String, number: String, chapterViewed: Bool) {
        guard chapterArray.isEmpty != true else {
            return
        }
        
        let chapters = realm.objects(MangaChapterPersistance.self).filter(NSPredicate(format: "chapterID = %@ AND chapterNumber = %@", ID, number))
        
        if let chapter = chapters.first {
            
            guard chapter.wasChapterViewed == true else {
                print("CHAPTER WAS VIEWED IS FALSE")
                
                try! realm.write {
                    chapter.chapterTitle = chapterTitle
                    chapter.chapterID = ID
                    chapter.chapterNumber = number
                    chapter.wasChapterViewed = true
                }
                return
            }

        } else {
            print("New item added to realm")
            try! self.realm.write {
                chapterPersistance.chapterTitle = chapterTitle
                chapterPersistance.chapterID = ID
                chapterPersistance.chapterNumber = number
                chapterPersistance.wasChapterViewed = chapterViewed
                self.realm.add(chapterPersistance)
            }
        }
    }
    
    func removeViewedChapter(chapterTitle: String, ID: String, number: String) {
        guard chapterArray.isEmpty != true else {
            return
        }
        
        let chapters = realm.objects(MangaChapterPersistance.self).filter("chapterID = %@ && chapterNumber = %@", ID, number)
        
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
