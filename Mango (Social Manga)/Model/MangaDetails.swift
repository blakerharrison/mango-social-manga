//
//  MangaDetails.swift
//  Mango (Social Manga)
//
//  Created by Blake Harrison on 2/23/19.
//  Copyright © 2019 Blake Harrison. All rights reserved.
//

import Foundation

var currentManga = MangaDetails(name: "", author: "", category: "", released: "", description: "", imageURL: "", status: "")

struct MangaDetails {
    var name: String
    var author: String
    var category: String
    var released: String
    var description: String
    var imageURL: String
    var status: String
    
    init(name: String, author: String, category: String, released: String, description: String, imageURL: String, status: String) {
        self.name = name
        self.author = author
        self.category = category
        self.released = released
        self.description = description
        self.imageURL = imageURL
        self.status = status
    }
}
