//
//  InterestCollectionViewController.swift
//  Mango (Social Manga)
//test
//  Created by Blake Harrison on 1/25/18.
//  Copyright © 2018 Blake Harrison. All rights reserved.
//

import UIKit

class InterestViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var mangaLabel: UILabel!
    //MARK: Properties
    var interest = Interest.fetchInterests()
    let cellScaling: CGFloat = 0.6
    
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = floor(screenSize.width * cellScaling)
        let cellHeight = floor(screenSize.height * cellScaling)
        
        let insetX = (view.bounds.width - cellWidth) / 2.0
        let insetY = (view.bounds.height - cellHeight) / 2.0
        
        let layout = collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        collectionView?.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
        
        
        collectionView?.dataSource = self

    }
    
    // Action
    @IBAction func bleachSegue(_ sender: Any) {

        if mangaLabel.text == "Bleach" {
        print("Button Clicked 🐶")
        performSegue(withIdentifier: "segueBleach", sender: self)
        } else {
            print("Nothing")
        }
    }
    
    
    
}

// Cell Controller

extension InterestViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interest.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InterestCell", for: indexPath) as! MangaCollectionViewCell
        
        cell.interest = interest[indexPath.item]
        
        return cell
    }
    
}
