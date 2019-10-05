//
//  MangaReader.swift
//  Mango (Social Manga)
//
//  Created by Blake Harrison on 9/9/18.
//  Copyright © 2018 Blake Harrison. All rights reserved.
//

import UIKit
import SDWebImage

var pages = [PageOfChapter]()

class MangaReader: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    //MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityMain: UIActivityIndicatorView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var pageNumberLabel: UILabel!
    @IBOutlet weak var pageChapterLabel: UILabel!
    @IBOutlet weak var statusBarBackgroundImage: UIImageView!
    @IBOutlet weak var darkModeBackground: UIVisualEffectView!
    
    //MARK: - Properties
    let Networking = MangoNetworking()
    var refresher: UIRefreshControl!

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        activityMain.isHidden = false
        activityMain.startAnimating()
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadList(notification:)), name: NSNotification.Name(rawValue: "load"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(exitMangaReader(notification:)), name: .chaptersAreFinished, object: nil)

        self.Networking.fetchChapters(mangaID: selectedChapterID)

        collectionView.isScrollEnabled = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(toggleNavBar(notification:)), name: .toggle, object: nil)
        
        backButton.image = UIImage(named: "BackButton")

        pageChapterLabel.text = "Chapter " + currentChapter
        
        self.refresher = UIRefreshControl()
        self.collectionView!.alwaysBounceVertical = true
        self.refresher.tintColor = UIColor.darkGray
        self.refresher.addTarget(self, action: #selector(loadData), for: .valueChanged)
        self.collectionView!.addSubview(refresher)
        
        collectionView.register(UINib(nibName: "transitionCell", bundle: nil), forCellWithReuseIdentifier: "tranCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
        if GeneralUtils.isDarkModeEnabled() {
            darkModeBackground.isHidden = false
            statusBarBackgroundImage.isHidden = true
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationController?.isNavigationBarHidden = false

    }
    
    deinit {
        pages.removeAll()
    }
    
    //MARK: - Methods
    @objc func loadData() {
        pageNumberLabel.text = "Loading Previous Chapter"

        pages.removeAll()

        self.Networking.fetchPages(chapterID: selectedChapterID)
        
        stopRefresher()         //Call this to stop refresher
    }
    
    func stopRefresher() {
        self.refresher.endRefreshing()
    }
    
    @objc func loadList(notification: NSNotification) {
        DispatchQueue.main.async {
            print("LOADED")
            self.collectionView.reloadData()
            self.collectionView.contentOffset = .zero
            self.pageNumberLabel.text = "1 /\(self.Networking.fetchedPagesNumbers.count)"
        }
    }
    
    @objc func exitMangaReader(notification: NSNotification) {
        print("Exit Manga Reader Activated")
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func toggleNavBar(notification: NSNotification) {
        if self.navBar.isHidden == false {
            print("Hiding Nav Bar")
            self.navBar?.isHidden = true
            self.toolBar?.isHidden = true
            self.pageNumberLabel?.isHidden = true
            self.pageChapterLabel?.isHidden = true
            if !GeneralUtils.isDarkModeEnabled() {
                self.statusBarBackgroundImage?.isHidden = true
            }
            return
        } else {
            print("Showing Nav Bar")
            self.navBar?.isHidden = false
            self.toolBar?.isHidden = false
            self.pageNumberLabel?.isHidden = false
            self.pageChapterLabel?.isHidden = false
            if !GeneralUtils.isDarkModeEnabled() {
                self.statusBarBackgroundImage?.isHidden = false
            }
        }
    }

    //MARK: - Actions
    @IBAction func backButtonAction(_ sender: Any) {
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func shopButton(_ sender: Any) {
        print("Shop button clicked")
    }
    
    //MARK: - CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // first row
        if indexPath.row == pages.count + 1 {
            let tranCell = collectionView.dequeueReusableCell(withReuseIdentifier: "tranCell", for: indexPath)
            
            // setup the cell...
            
            return tranCell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PageCell", for: indexPath) as! MangaReaderCell

        activityMain.isHidden = true
        activityMain.stopAnimating()

        cell.activityIndicator.isHidden = false
        cell.activityIndicator.startAnimating()
        
        if let pageLabel = cell.viewWithTag(101) as? UILabel {
            pageLabel.text = String(pages[indexPath.row].pageNumber)
            }

        cell.pageImage.sd_setImage(with: URL(string: Networking.mangaImageURL + pages.reversed()[indexPath.row].imageURL)!, placeholderImage: UIImage(),
                                   completed: { image, error, cacheType, imageURL in
                                    
                                    DispatchQueue.main.async {
                                        
                                        cell.activityIndicator.isHidden = true
                                        cell.activityIndicator.stopAnimating()
                                        collectionView.isScrollEnabled = true
                                        
                                    }
        })
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row != Networking.fetchedPagesURLs.count - 1 {
            
        pageNumberLabel.text = "Page \(pages.reversed()[indexPath.row].pageNumber + 1) /\(pages.count)"
            
        } else {
            
            pageNumberLabel.text = "Loading Next Chapter"
            activityMain.isHidden = false
            activityMain.startAnimating()

            print("Load next chapter.")
            print("Current chapter \(selectedChapterID)")

            mangaDataStructure.nextID()

            selectedIndex = selectedIndex - 1
            
            pages.removeAll()
            
            Networking.fetchChapters(mangaID: selectedChapterID)
            
            print("")

            print("Next chapter \(selectedChapterID)")
        }
    }
    
}

extension Notification.Name {
    static let toggle = Notification.Name("true")
    static let chaptersAreFinished = Notification.Name("chaptersCompleted")
}
