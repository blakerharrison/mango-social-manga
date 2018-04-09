//
//  ImageArray.swift
//  Mango (Social Manga)
//
//  Created by Blake Harrison on 4/8/18.
//  Copyright © 2018 Blake Harrison. All rights reserved.
//

import Foundation

//51


/// GETS the image of the provided Naruto page number from http://manganelo.com/ .
///
/// - Parameter page: Page number.
/// - Returns: URL of the page.
public func narutoImage(page: Int)-> String {
    
  return "http://s3.mgicdn.com/read_naruto_manga_online_free3/vol1_chapter_1_uzumaki_naruto/" + String(page) + ".jpg"
}


