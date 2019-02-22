//
//  PageOfChapter.swift
//  Mango (Social Manga)
//
//  Created by Blake Harrison on 2/15/19.
//  Copyright © 2019 Blake Harrison. All rights reserved.
//

import Foundation
import SwiftyJSON

struct PageOfChapter {
    var pageNumber: Int
    var imageURL: String
    
    init(pageNumber: Int, imageURL: String) {
        self.pageNumber = pageNumber
        self.imageURL = imageURL
    }
}

