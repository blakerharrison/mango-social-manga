//
//  NarutoPage4.swift
//  Mango (Social Manga)
//
//  Created by Blake Harrison on 4/9/18.
//  Copyright © 2018 Blake Harrison. All rights reserved.
//

import UIKit

class NarutoPage4: MangaPageViewController, UIScrollViewDelegate {
    
    let currentPage = pageNumber + 3
    
    //MARK: Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadImage(theUrl: mangaImages(manga: "Naruto", chapter: 109088, page: 4), theImageView: imageView)
        
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 2.5
        
        
        print(currentPage)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        endOfChapter(currentPage: currentPage)
    }
    
    //MARK: Functions
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    //MARK: End of Chapter
    func endOfChapter(currentPage: Int) {
        if currentPage == pagesContainedInChapter(manga: "Naruto", chapter: 109088) {
            
            //ALERT
            let alertController = UIAlertController(title: "End of Chapter", message: "Start next chapter?", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "No", style: .cancel) { action in
                self.performSegue(withIdentifier: "Home", sender: self)
            }
            alertController.addAction(cancelAction)
            
            let OKAction = UIAlertAction(title: "Yes", style: .default) { action in
                print("Next Chapter Placeholder")
            }
            alertController.addAction(OKAction)
            
            self.present(alertController, animated: true) {
                // ...
            }
            
        }
    }
    
}
