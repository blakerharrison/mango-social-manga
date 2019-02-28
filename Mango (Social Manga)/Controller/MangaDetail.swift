//
//  MangaDetail.swift
//  Mango (Social Manga)
//
//  Created by Blake Harrison on 9/6/18.
//  Copyright © 2018 Blake Harrison. All rights reserved.
//

import UIKit
import SwiftyJSON
import RealmSwift
import SkeletonView

var selectedIndex = 0
var selectedID = ""
var selectedChapterID = ""
var currentChapter = ""
var mangaDataStructure = MangaDataStructure()

var currentMangaObject = RealmMangaObject()
var currentChaptersObject = RealmChapterObject()
var wasChapterViewed = RealmChapterViewed()

var chaptersArray = [MangaChapter]()

var chaptersArray2 = [[Any]]()

class MangaDetail: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Properties
    let networking = MangoNetworking()
    var mangaChapters: [[MetadataType?]] = [[]]
    let realmManager = RealmManager()

    //MARK: - Outlets
    @IBOutlet weak var mangaImage: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var mangaDescription: UITextView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var releasedLabel: UILabel!
    @IBOutlet weak var readButton: UIButton!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var descriptionTitle: UILabel!
    @IBOutlet weak var activityDetails: UIActivityIndicatorView!
    @IBOutlet weak var activityImage: UIActivityIndicatorView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        realmManager.deleteEverything()

        realmManager.printFilePath()
        
        mangaImage.addShadow()
        mangaImage.alpha = 0.5
        mangaImage.isSkeletonable = true
        mangaImage.showAnimatedGradientSkeleton()

        activity.isHidden = false
        activity.startAnimating()
        
        activityDetails.isHidden = false
        activityDetails.startAnimating()
        
        activityImage.isHidden = true

        toggleIsMangaBeingViewed()
        
        NotificationCenter.default.addObserver(self, selector: #selector(ReloadTableView(_:)), name: .ChapterWasAppended, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(UpdateUI(_:)), name: .ChapterDetailsWereFetched, object: nil)

        self.navigationController?.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.font: UIFont(name: Fonts.Knockout.rawValue, size: 21)!]
        navigationItem.title = searchedMangaList[selectedIndex].t!

        readButton.layer.cornerRadius = 5
    }
    
    override func viewWillAppear(_ animated: Bool) {
        chapterArray.removeAll()
        networking.fetchChapterDetails(chapterID: selectedID)
        networking.fetchChapters(mangaID: selectedID)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        selectedIndex = 0
        currentManga = MangaDetails(name: "", author: "", category: "", released: "", description: "", imageURL: "", status: "")
    }
    
    deinit {
        print("Memory to be released soon")
    }
    
    //MARK: - Methods
    @objc func ReloadTableView(_ notification: Notification) {
        DispatchQueue.main.async {
            chapterArray.reverse()
            self.tableView.reloadData()
            self.activity.isHidden = true
            self.activity.stopAnimating()
        }
    }
    
    @objc func UpdateUI(_ notification: Notification) {
        self.fetchImage()
        
        DispatchQueue.main.async {
            self.mangaDescription.text = currentManga.description
            self.authorLabel.text = "Author : " + currentManga.author
            self.categoriesLabel.text = "Category : " + currentManga.category
            self.releasedLabel.text = "Released : " + currentManga.released
            self.statusLabel.text = "Status : " + currentManga.status
            self.descriptionTitle.text = "Description : "
            
            self.activityDetails.isHidden = true
            self.activityDetails.stopAnimating()
        }
    }
    
    fileprivate func setUIImage(_ data: Data?) {
        DispatchQueue.main.async {
            
            self.mangaImage.alpha = 1.0
            self.mangaImage.image = UIImage(data: data!)
            self.mangaImage.stopSkeletonAnimation()
            self.mangaImage.hideSkeleton()
            self.activityImage.isHidden = true
            self.activityImage.stopAnimating()
        }
    }
    
    
    func toggleIsMangaBeingViewed() {
        networking.isMangaDetailBeingViewed = false
    }
    
    //MARK: - Networking
    func fetchImage() { //TODO: Move to MangoNetworking
        guard currentManga.imageURL != networking.mangaImageURL else {
            
            DispatchQueue.main.async {
                self.mangaImage.alpha = 1.0
                self.mangaImage.stopSkeletonAnimation()
                self.mangaImage.hideSkeleton()
                self.activityImage.isHidden = true
                self.activityImage.stopAnimating()
            }

            print("No Image")
            return
        }

        guard let url = URL(string: currentManga.imageURL) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("Failed fetching image:", error!)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Not a proper HTTPURLResponse or statusCode")
                
                let alert = UIAlertController(title: "Connection Error", message: "404", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
                return
            }
            
            self.setUIImage(data)
            
            }.resume()
    }

    //MARK: - Actions
    @IBAction func reverseChapterOrder(_ sender: Any) {
        guard mangaDataStructure.isMangaChaptersReversed == false else {
            
            mangaDataStructure.mangaChaptersString.reverse()
            mangaDataStructure.reverseIDs()
            tableView.reloadData()
            mangaDataStructure.isMangaChaptersReversed = false
            return
        }
        
        mangaDataStructure.mangaChaptersString.reverse()
        mangaDataStructure.reverseIDs()
        tableView.reloadData()
        
        mangaDataStructure.isMangaChaptersReversed = true
        
        print("Structure of the Manga is \(mangaDataStructure.isMangaChaptersReversed)")
    }

    //MARK: - Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chapterArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chapters", for: indexPath)
        cell.accessoryType = .none
        
        if let label = cell.viewWithTag(1000) as? UILabel {
            
            label.text = "\(chapterArray[indexPath.row].number) - \(chapterArray[indexPath.row].title)"
            
        }
        
        if realmManager.realm.objects(MangaChapterPersistance.self).count > 0 {
//            print("There's data!")

            let chapters = realmManager.realm.objects(MangaChapterPersistance.self).filter("chapterID = %@", chapterArray[indexPath.row].id)
            
            if let chapter = chapters.first
            {
                
//                print("Does \(chapter.wasChapterViewed) == true? and does \(chapterArray[indexPath.row].id) == \(chapter.chapterID)")
                
                if chapter.wasChapterViewed == true && chapterArray[indexPath.row].id == chapter.chapterID {
                    cell.accessoryType = .checkmark
                }
            }
        } else {
            print("No realm data yet.")
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        realmManager.addViewedChapter(ID: chapterArray[indexPath.row].id, chapterViewed: true)
        
        print(chapterArray[indexPath.row])

        networking.fetchPages(chapterID: chapterArray[indexPath.row].chapterPath)

        currentChapter = String(chapterArray[indexPath.row].number)

        self.tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "readerSegue", sender: self)
    }
    
     func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chapters", for: indexPath)
        
        let markUnread = UITableViewRowAction(style: .normal, title: "Mark Unread") { action, index in
            if self.realmManager.realm.objects(MangaChapterPersistance.self).count > 0 {
                print("There's data!")
                
                let chapters = self.realmManager.realm.objects(MangaChapterPersistance.self).filter("chapterID = %@", chapterArray[indexPath.row].id)
                
                if let chapter = chapters.first
                {
                    if chapter.wasChapterViewed == true && chapterArray[indexPath.row].id == chapter.chapterID {
                        self.realmManager.addViewedChapter(ID: chapterArray[indexPath.row].id, chapterViewed: false)
                        cell.accessoryType = .none
                        tableView.reloadData()
                    }
                }
            } else {
                print("No realm data yet.")
            }
        }
        markUnread.backgroundColor = .lightGray

        return [markUnread]
    }
}

// URLContainer
extension Notification.Name {
    static let ChapterWasAppended = NSNotification.Name("ChapterWasAppended")
    
    static let ChapterDetailsWereFetched = NSNotification.Name("ChapterDetailsWereFetched")
    
    static let MangaDetailWasExited  = NSNotification.Name("MangaDetailWasExited")
}
