//
//  MangaObject.swift
//  Mango (Social Manga)
//
//  Created by Blake Harrison on 8/23/18.
//  Copyright © 2018 Blake Harrison. All rights reserved.
//

import UIKit

var usersFavoriteMangas = [MangaObject]()

struct MangaObject {
    var mangaCover: UIImage?
    var mangaTitles: String?
    
    init(mangaCover: UIImage? = nil, mangaTitles: String? = nil) {
        self.mangaCover = mangaCover
        self.mangaTitles = mangaTitles
    }
}
