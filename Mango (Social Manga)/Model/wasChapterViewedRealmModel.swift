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

final class RealmMangaObject: Object {
    @objc dynamic var mangaID: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var chapters: [RealmChapterObject] = []
}

final class RealmChapterObject: Object {
    @objc dynamic var chapterIDs: String = ""
    @objc dynamic var viewed: Bool = false
}

