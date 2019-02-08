//
//  MangaObject.swift
//  Mango (Social Manga)
//
//  Created by Blake Harrison on 8/23/18.
//  Copyright © 2018 Blake Harrison. All rights reserved.
//

import UIKit

var usersFavoriteMangas = [MangaObject]()

//Appended when user searches a Manga.
var searchedMangaList = [manga]()

struct MangaObject {
    var mangaCover: UIImage?
    var mangaTitles: String?
    
    init(mangaCover: UIImage? = nil, mangaTitles: String? = nil) {
        self.mangaCover = mangaCover
        self.mangaTitles = mangaTitles
    }
}

struct MangaList: Codable {
    let end: Int
    let manga: [manga]
    let page: Int
    let start: Int
    let total: Int
}

struct manga: Codable {
    let a: String?
    let c: [String]?
    let h: Int?
    let i: String?
    let im: String?
    let ld: Int?
    let s: Int?
    let t: String?
}

