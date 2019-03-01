//
//  Home.swift
//  Mango (Social Manga)
//
//  Created by Blake Harrison on 8/17/18.
//  Copyright © 2018 Blake Harrison. All rights reserved.
//

import UIKit
import SDWebImage

let YEET = [MangaObject(mangaCover: UIImage(named: "RalGrad"), mangaTitles: "Ral Grad")]
var favoritedManga = [MangaDetails]()

class Home: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        tableView.reloadData()
    }
}

//MARK: TableView
extension Home: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard favoritedManga.count > 0 else {
            return 1
        }
        
        return favoritedManga.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if favoritedManga.count > 0 {
            var mangaTitle = UILabel()
            mangaTitle = cell.viewWithTag(1001) as! UILabel
            mangaTitle.text = favoritedManga[indexPath.row].name
            
            var mangaImageView = UIImageView()
            mangaImageView = cell.viewWithTag(1000) as! UIImageView
            mangaImageView.sd_setImage(with: URL(string: favoritedManga[indexPath.row].imageURL), placeholderImage: UIImage(named: "TransitionScreenBW3"))
            
//            var mangaImage = UIImageView()
//            mangaImage = cell.viewWithTag(1000) as! UIImageView
//            cell.mangaImage.sd_setImage(with: URL(string: favoritedManga[indexPath.row].imageURL)!, placeholderImage: UIImage(),
//                                       completed: { image, error, cacheType, imageURL in
//
//                                        DispatchQueue.main.async {
//
//                                            cell.activityIndicator.isHidden = true
//                                            cell.activityIndicator.stopAnimating()
//                                            collectionView.isScrollEnabled = true
//
//                                        }
//            })
            
        } else if favoritedManga.count == 0 {
            var mangaCoverImage = UIImageView()
            mangaCoverImage = cell.viewWithTag(1000) as! UIImageView
            mangaCoverImage.image = UIImage(named: "FavoriteMangaMessage")
        }
        

        
        return cell
    }
    
    
}

