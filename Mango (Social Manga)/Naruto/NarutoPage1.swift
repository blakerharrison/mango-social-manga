//
//  NarutoPage1.swift
//  Mango (Social Manga)
//
//  Created by Blake Harrison on 4/8/18.
//  Copyright © 2018 Blake Harrison. All rights reserved.
//

import UIKit

class NarutoPage1: UIViewController, UIScrollViewDelegate {

    //MARK: Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.orange;

//        loadImage(theUrl: narutoImage(page: 1), theImageView: imageView)
       loadImage(theUrl: narutoImage(chapter: 109088, page: 1), theImageView: imageView)
        
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 2.5
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
         navigationController?.hidesBarsOnTap = true
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
    
    //MARK: Functions
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
}
