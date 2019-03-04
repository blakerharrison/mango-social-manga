//
//  Shadow.swift
//  Mango (Social Manga)
//
//  Created by Blake Harrison on 8/23/18.
//  Copyright © 2018 Blake Harrison. All rights reserved.
//

import UIKit

//MARK: Extensions
extension UIView {
    
    func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.75
        layer.shadowRadius = 5
        clipsToBounds = false
    }
    
}

extension UILabel {
    
    func addLabelShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 2
        clipsToBounds = false
    }
}
