//
//  MangaObject.swift
//  MangoObjectSwiftJSON
//
//  Created by Blake Harrison on 2/11/19.
//  Copyright © 2019 Blake Harrison. All rights reserved.
//

import Foundation
import SwiftyJSON

struct MangaChapter {
    var number: Int
    var date: NSDate
    var title: String
    var id: String
    
    init(number: Int, date: NSDate, title: String, id: String) {
        self.number = number
        self.date = date
        self.title = title
        self.id = id
    }
}
