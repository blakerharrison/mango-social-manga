//
//  MangaReader.swift
//  Mango (Social Manga)
//
//  Created by Blake Harrison on 9/9/18.
//  Copyright © 2018 Blake Harrison. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

class MangaReader: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    //MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityMain: UIActivityIndicatorView!
    
    //MARK: - Properties
    let Networking = MangoNetworking()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(loadList(notification:)), name: NSNotification.Name(rawValue: "load"), object: nil)
        self.Networking.fetchMangaChapterInfo(chapterID: selectedChapterID)
        
        activityMain.isHidden = false
        activityMain.startAnimating()
        collectionView.isScrollEnabled = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //MARK: - Methods
    @objc func loadList(notification: NSNotification) {
        DispatchQueue.main.async {
        self.collectionView.reloadData()
        }
    }
    
    //MARK: - CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Networking.fetchedPagesURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PageCell", for: indexPath)

        if let activity = cell.viewWithTag(103) as? UIActivityIndicatorView {
            activityMain.isHidden = true
            activityMain.stopAnimating()
            activity.isHidden = false
            activity.startAnimating()
            
        }
        
        DispatchQueue.main.async {
        if let pageLabel = cell.viewWithTag(101) as? UILabel {
            pageLabel.text = self.Networking.fetchedPagesNumbers.reversed()[indexPath.row]
            }
        }
        
        if let image = cell.viewWithTag(100) as? UIImageView {
            
            image.image = nil

            DispatchQueue.global(qos: .background).async {
                do{
                    let data = try Data.init(contentsOf: URL.init(string:self.Networking.fetchedPagesURLs.reversed()[indexPath.row])!)
                    DispatchQueue.main.async {
  
                        let imageToCache = UIImage(data: data)!
                        
                        imageCache.setObject(imageToCache, forKey: self.Networking.fetchedPagesURLs.reversed()[indexPath.row] as NSString )
                        
                        image.image = imageToCache
                        
//                        let pageImage: UIImage =
//                        image.image = pageImage
                    }
                }
                catch {
                    // error
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print(indexPath)
        
        
    }

}

//MARK: Extensions
extension MangaReader: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let frameSize = collectionView.frame.size
        return CGSize(width: frameSize.width - 0, height: frameSize.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if self.navigationController?.isNavigationBarHidden == false {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        } else if self.navigationController?.isNavigationBarHidden == true {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            
            print(indexPath)
        }
    }
}
