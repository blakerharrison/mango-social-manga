//
//  NarutoPage4.swift
//  Mango (Social Manga)
//
//  Created by Blake Harrison on 4/9/18.
//  Copyright © 2018 Blake Harrison. All rights reserved.
//

import UIKit

class NarutoPage4: UIViewController, UIScrollViewDelegate {
    
    //MARK: Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadImage(theUrl: narutoImage(chapter: 109088, page: 4), theImageView: imageView)
        
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 2.5
    }
    
    //MARK: Functions
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
}
