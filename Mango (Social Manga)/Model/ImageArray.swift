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
public func mangaImages(manga: String, chapter: Int, page: Int)-> String {
    
    if manga == "Naruto" {
        return "https://res.cloudinary.com/dfd4ae1lw/image/upload/v1523298421/MR-6841-" + String(chapter) + "-" + String(page) + ".jpg.jpg"
    }
    
    return "No Manga"
}

public func pagesContainedInChapter(manga: String, chapter: Int)-> Int {
    
    if manga == "Naruto" {
        //Chapter 1
        if chapter == 109088 {
            return 53
        } else
        //Chapter 2
        if chapter == 109089 {
            return 5
        }
    }
    return 0
}

public func NarutoChapterNumbers(chapter: Int)-> Int {
    
    if chapter == 109088 {
        return 40
    }
    
    return 0
}


//109088 = Chapter 1
//109088 = Chapter 2
