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
