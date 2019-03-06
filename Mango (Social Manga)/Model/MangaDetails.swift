//
//  MangaDetails.swift
//  Mango (Social Manga)
//
//  Created by Blake Harrison on 2/23/19.
//  Copyright © 2019 Blake Harrison. All rights reserved.
//

import Foundation
import RealmSwift

var currentManga = MangaDetails(name: "", author: "", category: "", released: "", description: "", imageURL: "", status: "", id: "")

struct MangaDetails {
    var name: String
    var author: String
    var category: String
    var released: String
    var description: String
    var imageURL: String
    var status: String
    var id: String
    
    init(name: String, author: String, category: String, released: String, description: String, imageURL: String, status: String, id: String) {
        self.name = name
        self.author = author
        self.category = category
        self.released = released
        self.description = description
        self.imageURL = imageURL
        self.status = status
        self.id = id
    }
}

//Realm Object
class MangaDetailsRealm: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var author: String = ""
    @objc dynamic var category: String = ""
    @objc dynamic var released: String = ""
    @objc dynamic var about: String = ""
    @objc dynamic var imageURL: String = ""
    @objc dynamic var status: String = ""
    @objc dynamic var id: String = ""
}
