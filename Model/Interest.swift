//
//  Interest.swift
//  Mango (Social Manga)
//
//  Created by Blake Harrison on 1/25/18.
//  Copyright © 2018 Blake Harrison. All rights reserved.
//

import Foundation
import UIKit

class Interest
{
    // MARK: - Public API
    var title = ""
    var featuredImage: UIImage
    var color: UIColor
    
    init(title: String, featuredImage: UIImage, color: UIColor)
    {
        self.title = title
        self.featuredImage = featuredImage
        self.color = color
    }
    
    // MARK: - Private
    // dummy data
    static func fetchInterests() -> [Interest]
    {
        return [
            Interest(title: "Bleach", featuredImage: UIImage(named: "f1")!, color: UIColor(red: 63/255.0, green: 71/255.0, blue: 80/255.0, alpha: 0.8)),
            Interest(title: "Naruto", featuredImage: UIImage(named: "f2")!, color: UIColor(red: 255/255.0, green: 163/255.0, blue: 0/255.0, alpha: 0.7)),
            Interest(title: "One Piece", featuredImage: UIImage(named: "f3")!, color: UIColor(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.5)),
            Interest(title: "Tokyo Ghoul", featuredImage: UIImage(named: "f4")!, color: UIColor(red: 158/255.0, green: 0/255.0, blue: 255/255.0, alpha: 0.7)),
            Interest(title: "Dragon Ball Z", featuredImage: UIImage(named: "f5")!, color: UIColor(red: 0/255.0, green: 26/255.0, blue: 255/255.0, alpha: 0.6))
        ]
    }
}
