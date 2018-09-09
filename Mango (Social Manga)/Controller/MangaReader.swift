//
//  MangaReader.swift
//  Mango (Social Manga)
//
//  Created by Blake Harrison on 9/9/18.
//  Copyright © 2018 Blake Harrison. All rights reserved.
//

import UIKit

class MangaReader: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    let mangaPages = [UIImage(named: "testManga1"), UIImage(named: "testManga2"), UIImage(named: "testManga3"), UIImage(named: "f1"), UIImage(named: "f2"), UIImage(named: "f3")]
    
    //MARK: - Outlets
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    //MARK: - CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mangaPages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PageCell", for: indexPath)
        if let image = cell.viewWithTag(100) as? UIImageView {
            image.image = mangaPages[indexPath.row]
        }

        return cell
    }
    
}

