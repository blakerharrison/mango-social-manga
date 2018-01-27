//
//  PageOneViewController.swift
//  Mango (Social Manga)
//
//  Created by Blake Harrison on 1/26/18.
//  Copyright © 2018 Blake Harrison. All rights reserved.
//

import UIKit

class PageOneViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mangaPage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 6.0
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.mangaPage
    }
}
