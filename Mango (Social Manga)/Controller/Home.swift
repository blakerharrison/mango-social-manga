//
//  Home.swift
//  Mango (Social Manga)
//
//  Created by Blake Harrison on 8/17/18.
//  Copyright © 2018 Blake Harrison. All rights reserved.
//

import UIKit
import SDWebImage
import SwiftReorder
import RealmSwift

var favoritedManga = [MangaDetailsRealm]()

//MARK: Object
class Home: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var darkModeBackground: UIVisualEffectView!
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        RealmManager().printFilePath()
        
        tableView.reorder.delegate = self
        
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.font: UIFont(name: Fonts.Knockout.rawValue, size: 21)!]
        RealmManager().readFavoritedMangas()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        RealmManager().readFavoritedMangas()
        
        if GeneralUtils.isDarkModeEnabled() {
            darkModeBackground.isHidden = false
        } else {
            darkModeBackground.isHidden = true
        }
        
        tableView.reloadData()
        
    }
    
    

}

//MARK: TableView
extension Home: UITableViewDelegate, UITableViewDataSource, TableViewReorderDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard favoritedManga.count > 0 else {
            return 0
        }
        
        return favoritedManga.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if let spacer = tableView.reorder.spacerCell(for: indexPath) {
            return spacer
        }
        
        cell.selectionStyle = .none
        
        if !favoritedManga.isEmpty {
            if let mangaTitle = cell.viewWithTag(1001) as? UILabel {
                mangaTitle.text = favoritedManga[indexPath.row].name
                mangaTitle.addLabelShadow()
            }
            
            if let mangaImageView = cell.viewWithTag(1000) as? UIImageView {
                mangaImageView.sd_setImage(with: URL(string: favoritedManga[indexPath.row].imageURL), placeholderImage: UIImage(named: "TransitionScreenBW3"))
                mangaImageView.addShadow()
            }
            
        } else if favoritedManga.isEmpty {
            var mangaCoverImage = UIImageView()
            mangaCoverImage = cell.viewWithTag(1000) as! UIImageView
            mangaCoverImage.image = nil
            
            if let mangaTitle = cell.viewWithTag(1001) as? UILabel {
                mangaTitle.text = nil
            }
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard favoritedManga.isEmpty != true else {
            return
        }

        selectedID = favoritedManga[indexPath.row].id
        
        performSegue(withIdentifier: "userSelected", sender: self)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let remove = UITableViewRowAction(style: .normal, title: "Remove") { action, index in
            RealmManager().deleteFavoritedManga(id: favoritedManga[indexPath.row].id)
            favoritedManga.remove(at: indexPath.row)
            
            RealmManager().reorderFavorites()
            
            tableView.reloadData()
        }
        remove.backgroundColor = .red
        
        return [remove]
    }
    
    func tableView(_ tableView: UITableView, reorderRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let element = favoritedManga.remove(at: sourceIndexPath.row)
        favoritedManga.insert(element, at: destinationIndexPath.row)
        
        RealmManager().reorderFavorites()

        tableView.reloadData()
    }
}
