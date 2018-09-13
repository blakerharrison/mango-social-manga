//
//  Home.swift
//  Mango (Social Manga)
//
//  Created by Blake Harrison on 8/17/18.
//  Copyright © 2018 Blake Harrison. All rights reserved.
//

import UIKit

class Home: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: - Outlets
    @IBOutlet weak var homeView: UIView!

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        //TODO: This will be added the collection view based on the users selected favorite
        usersFavoriteMangas.append(MangaObject(mangaCover: UIImage(named: "One Piece 1"), mangaTitles: "One Piece"))
        usersFavoriteMangas.append(MangaObject(mangaCover: UIImage(named: "Naruto 1"), mangaTitles: "Naruto"))
        usersFavoriteMangas.append(MangaObject(mangaCover: UIImage(named: "Bleach"), mangaTitles: "Bleach"))

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    //MARK: - Actions
    @IBAction func menuTapped(_ sender: Any) {
    }
    
    //MARK: - CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return usersFavoriteMangas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCell", for: indexPath)
        if let image = cell.viewWithTag(100) as? UIImageView {
            image.image = usersFavoriteMangas[indexPath.row].mangaCover
            image.addShadow()
        }
        
        if let label = cell.viewWithTag(101) as? UILabel  {
            label.text = usersFavoriteMangas[indexPath.row].mangaTitles
            label.addLabelShadow()
        }
        return cell
    }
    
}

