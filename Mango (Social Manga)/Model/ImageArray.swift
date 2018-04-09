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
/// - Parameter chapter: Chapter ID. 109088 = Chapter 1
/// - Parameter page: Page number.
/// - Returns: URL of the page.
public func narutoImage(chapter: Int, page: Int)-> String {
    return "https://res.cloudinary.com/dfd4ae1lw/image/upload/v1523298421/MR-6841-" + String(chapter) + "-" + String(page) + ".jpg.jpg"
}

//109088 = Chapter 1
//109088 = Chapter 2
