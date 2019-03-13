//
//  Home.swift
//  Mango (Social Manga)
//
//  Created by Blake Harrison on 8/17/18.
//  Copyright © 2018 Blake Harrison. All rights reserved.
//

import UIKit
import SDWebImage

var favoritedManga = [MangaDetailsRealm]()

//MARK: Object
class Home: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dragDelegate = self
        tableView.dragInteractionEnabled = true
        
        
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
extension Home: UITableViewDelegate, UITableViewDataSource, UITableViewDragDelegate, UITableViewDropDelegate {
    //MARK: - Drag Action
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let item = favoritedManga[indexPath.row].name
        let itemProvider = NSItemProvider(object: item as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = item
        
        return [dragItem]
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        print("Dropped")
    }
    
    func tableView(_ tableView: UITableView, dragPreviewParametersForRowAt indexPath: IndexPath) -> UIDragPreviewParameters? {
        let book = UIDragPreviewParameters()
        book.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0)
        return book
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard favoritedManga.count > 0 else {
            return 0
        }
        
        return favoritedManga.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
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

