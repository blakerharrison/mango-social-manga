//
//  NarutoPage2.swift
//  Mango (Social Manga)
//
//  Created by Blake Harrison on 4/8/18.
//  Copyright © 2018 Blake Harrison. All rights reserved.
//

import UIKit

class NarutoPage2: UIViewController, UIScrollViewDelegate {

    //MARK: Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadImage(theUrl: narutoImage(chapter: 109088, page: 2), theImageView: imageView)
        
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 2.5
    }
    
    //MARK: Functions
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }


}
