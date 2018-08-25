//
//  Mango__Social_Manga_Tests.swift
//  Mango (Social Manga)Tests
//
//  Created by Blake Harrison on 8/22/18.
//  Copyright © 2018 Blake Harrison. All rights reserved.
//

import XCTest
@testable import Mango__Social_Manga_

class Mango__Social_Manga_Tests: XCTestCase {
    
    //If manga does not append to usersFavoriteManga the test will fail.
    func testMangaObjectIsAppendedToUsersFavoriteMangas() {
        usersFavoriteMangas.append(MangaObject(mangaCover: UIImage(named: "Bleach"), mangaTitles: "Bleach"))

        XCTAssertFalse(usersFavoriteMangas.isEmpty)
    }

}
