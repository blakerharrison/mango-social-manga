//
//  Home.swift
//  Mango (Social Manga)
//
//  Created by Blake Harrison on 8/17/18.
//  Copyright © 2018 Blake Harrison. All rights reserved.
//

import UIKit

var mangaCovers: [UIImage] = [UIImage(named: "Bleach.jpg")!, UIImage(named: "Naruto 1.jpg")!, UIImage(named: "One Piece 1.jpg")!] //Covers will be loaded from MangaEden API.

class Home: UIViewController {

    //MARK: - Properties

    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
}

//MARK: - Extension
extension UIViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mangaCovers.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCell", for: indexPath)
        if let image = cell.viewWithTag(100) as? UIImageView {
            image.image = mangaCovers[indexPath.row]
        }
        
        return cell
    }

}
