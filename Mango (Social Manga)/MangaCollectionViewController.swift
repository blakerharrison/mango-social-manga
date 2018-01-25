//
//  MangaCollectionViewCell.swift
//  Mango (Social Manga)
//
//  Created by Blake Harrison on 1/25/18.
//  Copyright © 2018 Blake Harrison. All rights reserved.
//

import UIKit

class MangaCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var featuredImageView: UIImageView!
    @IBOutlet weak var mangaTitleLabel: UILabel!
    @IBOutlet weak var backgroundColorView: UIView!
    
    var interest: Interest? {
        didSet {
            self.updateUI()
        }
    }
    
    private func updateUI()
    {
        if let interest = interest {
            featuredImageView.image = interest.featuredImage
            mangaTitleLabel.text = interest.title
            backgroundColorView.backgroundColor = interest.color
        } else {
            featuredImageView.image = nil
            mangaTitleLabel.text = nil
            backgroundColorView.backgroundColor = nil
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 3.0
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 5, height: 10)
        
        self.clipsToBounds = false
    }
}
