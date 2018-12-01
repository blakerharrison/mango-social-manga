//
//  MangaReader.swift
//  Mango (Social Manga)
//
//  Created by Blake Harrison on 9/9/18.
//  Copyright © 2018 Blake Harrison. All rights reserved.
//

import UIKit
import SDWebImage

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
    
    //MARK: - Properties
    let Networking = MangoNetworking()
    var refresher: UIRefreshControl!

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadList(notification:)), name: NSNotification.Name(rawValue: "load"), object: nil)

        self.Networking.fetchMangaChapterInfo(chapterID: selectedChapterID)
        
        activityMain.isHidden = false
        activityMain.startAnimating()
        collectionView.isScrollEnabled = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(toggleNavBar(notification:)), name: .toggle, object: nil)
        
        backButton.image = UIImage(named: "BackButton")

        pageChapterLabel.text =
           "CHAPTER " + currentChapter
        
        //MARK: - ~NEW CODE~
        self.refresher = UIRefreshControl()
        self.collectionView!.alwaysBounceVertical = true
        self.refresher.tintColor = UIColor.darkGray
        self.refresher.addTarget(self, action: #selector(loadData), for: .valueChanged)
        self.collectionView!.addSubview(refresher)
        
        collectionView.register(UINib(nibName: "transitionCell", bundle: nil), forCellWithReuseIdentifier: "tranCell")

    }
    
    @objc func loadData() {
        pageNumberLabel.text = "Loading Previous Chapter"
        activityMain.isHidden = false
        activityMain.startAnimating()

        mangaDataStructure.previousID()

        self.Networking.fetchMangaChapterInfo(chapterID: selectedChapterID)
        
        stopRefresher()         //Call this to stop refresher
    }
    
    func stopRefresher() {
        self.refresher.endRefreshing()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    //MARK: - Methods
    @objc func loadList(notification: NSNotification) {
        DispatchQueue.main.async {
            self.pageChapterLabel.text = "CHAPTER " + mangaDataStructure.mangaChaptersString[mangaDataStructure.currentChapterIndex]
            print("LOADED")
            self.collectionView.reloadData()
            self.pageNumberLabel.text = "\(1) /\(self.Networking.fetchedPagesNumbers.count)"
            self.collectionView.contentOffset = .zero
        }
    }
    
    @objc func toggleNavBar(notification: NSNotification) {
        if self.navBar.isHidden == false {
            print("Hiding Nav Bar")
            self.navBar?.isHidden = true
            self.toolBar?.isHidden = true
            self.pageNumberLabel?.isHidden = true
            self.pageChapterLabel?.isHidden = true
            return
        } else {
            print("Showing Nav Bar")
            self.navBar?.isHidden = false
            self.toolBar?.isHidden = false
            self.pageNumberLabel?.isHidden = false
            self.pageChapterLabel?.isHidden = false
        }
    }

    //MARK: - Actions
    @IBAction func backButtonAction(_ sender: Any) {
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Networking.fetchedPagesURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // first row
        if indexPath.row == Networking.fetchedPagesURLs.count + 1 {
            let cameraCell = collectionView.dequeueReusableCell(withReuseIdentifier: "tranCell", for: indexPath)
            
            // setup the cell...
            
            return cameraCell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PageCell", for: indexPath) as! MangaReaderCell

        activityMain.isHidden = true
        activityMain.stopAnimating()
        cell.activityIndicator.isHidden = false
        cell.activityIndicator.startAnimating()

        if let pageLabel = cell.viewWithTag(101) as? UILabel {
            pageLabel.text = self.Networking.fetchedPagesNumbers.reversed()[indexPath.row]
            }

        cell.pageImage.sd_setImage(with: URL(string:self.Networking.fetchedPagesURLs.reversed()[indexPath.row])!, placeholderImage: UIImage(named: "DefaultPage"),
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
            
        pageNumberLabel.text = "\(self.Networking.fetchedPagesNumbers.reversed()[indexPath.row]) /\(self.Networking.fetchedPagesNumbers.count)"
            
        } else {
            
            pageNumberLabel.text = "Loading Next Chapter"
            activityMain.isHidden = false
            activityMain.startAnimating()

            print("Load next chapter.")
            print("Current chapter \(selectedChapterID)")

//            mangaDataStructure.currentChapterID = selectedChapterID
            
            mangaDataStructure.nextID()
            print("")

            print("Next chapter \(selectedChapterID)")

            self.Networking.fetchMangaChapterInfo(chapterID: selectedChapterID)
        }
    }
}

extension Notification.Name {
    static let toggle = Notification.Name("true")
}

