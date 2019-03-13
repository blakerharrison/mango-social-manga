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

class MangaFavorites: Object {
    @objc var title = ""
    let tags = List<MangaDetailsRealm>()
    
    convenience init(title: String, tag: MangaDetailsRealm) {
        self.init()
        self.title = title
        self.tags.append(MangaDetailsRealm())
    }
}

//MARK: Object
class Home: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.reorder.delegate = self
        
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.font: UIFont(name: Fonts.Knockout.rawValue, size: 21)!]
        RealmManager().readFavoritedMangas()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        tableView.reloadData()
    }

}

//MARK: TableView
extension Home: UITableViewDelegate, UITableViewDataSource, TableViewReorderDelegate {
    func tableView(_ tableView: UITableView, reorderRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {

        let element = favoritedManga.remove(at: sourceIndexPath.row)
        favoritedManga.insert(element, at: destinationIndexPath.row)

        tableView.reloadData()
        
    }
    
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
        
        if favoritedManga.count > 0 {
            var mangaTitle = UILabel()
            mangaTitle = cell.viewWithTag(1001) as! UILabel
            mangaTitle.text = favoritedManga[indexPath.row].name
            mangaTitle.addLabelShadow()
            
            var mangaImageView = UIImageView()
            mangaImageView = cell.viewWithTag(1000) as! UIImageView
            mangaImageView.sd_setImage(with: URL(string: favoritedManga[indexPath.row].imageURL), placeholderImage: UIImage(named: "TransitionScreenBW3"))
            mangaImageView.addShadow()

        } else if favoritedManga.count == 0 {
            var mangaCoverImage = UIImageView()
            mangaCoverImage = cell.viewWithTag(1000) as! UIImageView
            mangaCoverImage.image = nil
            var mangaTitle = UILabel()
            mangaTitle = cell.viewWithTag(1001) as! UILabel
            mangaTitle.text = nil
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let markUnread = UITableViewRowAction(style: .normal, title: "Remove") { action, index in
            RealmManager().deleteFavoritedManga(id: favoritedManga[indexPath.row].id)
            favoritedManga.remove(at: indexPath.row)
            tableView.reloadData()
        }
        markUnread.backgroundColor = .red
        
        return [markUnread]
    }
}

