//
//  MangaReader.swift
//  Mango (Social Manga)
//
//  Created by Blake Harrison on 9/9/18.
//  Copyright © 2018 Blake Harrison. All rights reserved.
//

import UIKit

class MangaReader: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    //MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Properties
    let Networking = MangoNetworking()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(loadList(notification:)), name: NSNotification.Name(rawValue: "load"), object: nil)
        self.Networking.fetchMangaChapterInfo(chapterID: selectedChapterID)
        sleep(5)
     
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //MARK: - Methods
    @objc func loadList(notification: NSNotification) {
        self.collectionView.reloadData()
    }


    //MARK: - CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Networking.fetchedPagesURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PageCell", for: indexPath)

        DispatchQueue.main.async {
        if let pageLabel = cell.viewWithTag(101) as? UILabel {
            pageLabel.text = self.Networking.fetchedPagesNumbers.reversed()[indexPath.row]
        }
        }
        
        if let image = cell.viewWithTag(100) as? UIImageView {
            DispatchQueue.global(qos: .background).async {
                do{
                    let data = try Data.init(contentsOf: URL.init(string:self.Networking.fetchedPagesURLs.reversed()[indexPath.row])!)
                    DispatchQueue.main.async {

                        let pageImage: UIImage = UIImage(data: data)!
                        image.image = pageImage
                    }
                }
                catch {
                    // error
                }
            }
        }
        return cell
    }

}

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
}
