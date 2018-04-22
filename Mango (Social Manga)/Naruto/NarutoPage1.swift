//
//  NarutoPage1.swift
//  Mango (Social Manga)
//
//  Created by Blake Harrison on 4/8/18.
//  Copyright © 2018 Blake Harrison. All rights reserved.
//

import UIKit

class NarutoPage1: MangaPageViewController, UIScrollViewDelegate {
    
    let currentPage = pageNumber
    
    var pref: UserDefaults = UserDefaults.standard
    
    //MARK: Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        loadImage(theUrl: mangaImages(manga: "Naruto", chapter: UserDefaults.standard.integer(forKey: "Naruto"), page: 1), theImageView: imageView)
        
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 2.5
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
         navigationController?.hidesBarsOnTap = true
        
        print(currentPage)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        endOfChapter(currentPage: currentPage)
        
        pref.set(false, forKey: "AutoTransition")
        
        self.navigationController?.navigationBar.tintColor = UIColor.orange; // Change back button to orange.
    }
    
    override var prefersStatusBarHidden: Bool {
        return navigationController?.isNavigationBarHidden == true
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return UIStatusBarAnimation.slide
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    //MARK: Functions
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    //MARK: End of Chapter
    func endOfChapter(currentPage: Int) {
        if currentPage == pagesContainedInChapter(manga: "Naruto", chapter: UserDefaults.standard.integer(forKey: "Naruto")) {
            
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
