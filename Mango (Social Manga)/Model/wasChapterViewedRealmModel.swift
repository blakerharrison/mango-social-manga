//
//  wasChapterViewedRealmModel.swift
//  Mango (Social Manga)
//
//  Created by Blake Harrison on 2/8/19.
//  Copyright © 2019 Blake Harrison. All rights reserved.
//

import Foundation
import RealmSwift

//"i" stands for ID.

//Stores manga data.
final class RealmMangaObject: Object {
    @objc dynamic var mangaID: String = ""
    @objc dynamic var name: String = ""
}

//Stores chapter data.
final class RealmChapterObject: Object {
    @objc dynamic var mangaID: String = ""
    @objc dynamic var chapterID: String = ""
}

final class RealmChapterViewed: Object {
    @objc dynamic var viewed: Bool = false
}

var mangaChapterTitleString = ""//DELETE
