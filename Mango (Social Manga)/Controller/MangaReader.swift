//
//  MangaReader.swift
//  Mango (Social Manga)
//
//  Created by Blake Harrison on 9/9/18.
//  Copyright © 2018 Blake Harrison. All rights reserved.
//

import UIKit
import SDWebImage

let imageCache = NSCache<NSString, UIImage>()

class MangaReader: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    //MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityMain: UIActivityIndicatorView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var toolBar: UIToolbar!
    
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(toggleNavBar(notification:)), name: .toggle, object: nil)
        
        backButton.image = UIImage(named: "BackButton")
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
        self.collectionView.reloadData()
        }
    }
    
    @objc func toggleNavBar(notification: NSNotification) {
        if self.navBar.isHidden == false {
            print("Hiding Nav Bar")
            self.navBar?.isHidden = true
            self.toolBar?.isHidden = true
            return
        } else {
            print("Showing Nav Bar")
            self.navBar?.isHidden = false
            self.toolBar?.isHidden = false
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
//                 navItem.title = String(indexPath.row)
        navItem.title = "\(self.Networking.fetchedPagesNumbers.reversed()[indexPath.row]) /\(self.Networking.fetchedPagesNumbers.count)"
    }
}

//MARK: - Custom Cell
class MangaReaderCell: UICollectionViewCell, UIScrollViewDelegate {
    
    @IBOutlet weak var pageImage: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func prepareForReuse() {
        super.prepareForReuse()

        self.pageImage.image = UIImage()
    }
    
    override func awakeFromNib() {
        self.scrollView.minimumZoomScale = 1
        self.scrollView.maximumZoomScale = 2.3
        self.scrollView.delegate = self
        scrollView.isUserInteractionEnabled = true
        
        let singleTap = UITapGestureRecognizer.init(target: self, action: #selector(self.TapGestureSingleTapped(recognizer:)))
        singleTap.numberOfTapsRequired = 1
        scrollView.addGestureRecognizer(singleTap)
        
        let doubleTap =  UITapGestureRecognizer.init(target: self, action: #selector(self.TapGestureTapped(recognizer:)))
        doubleTap.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTap)

        singleTap.require(toFail: doubleTap)
    }
    
    @objc func TapGestureTapped(recognizer: UITapGestureRecognizer) {
        if (scrollView.zoomScale > scrollView.minimumZoomScale) {
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        } else {
            let touchPoint = recognizer.location(in: scrollView)
            let scrollViewSize = scrollView.bounds.size
            
            let width = scrollViewSize.width / scrollView.maximumZoomScale
            let height = scrollViewSize.height / scrollView.maximumZoomScale
            let x = touchPoint.x - (width/2.0)
            let y = touchPoint.y - (height/2.0)
            
            let rect = CGRect(origin: CGPoint(x: x,y :y), size: CGSize(width: width, height: height))
            scrollView.zoom(to: rect, animated: true)
        }
    }
    
    @objc func TapGestureSingleTapped(recognizer: UITapGestureRecognizer) {
        NotificationCenter.default.post(name: .toggle, object: nil)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.pageImage
    }
}

//MARK: - Extensions
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

extension Notification.Name {
    static let toggle = Notification.Name("true")
}

