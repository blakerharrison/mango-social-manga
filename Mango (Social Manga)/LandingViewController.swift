//
//  LandingViewController.swift
//  Mango (Social Manga)
//
//  Created by Blake Harrison on 4/8/18.
//  Copyright © 2018 Blake Harrison. All rights reserved.
//

import UIKit
import SwiftCarousel

class LandingViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    let carouselFrame = CGRect(x: view.center.x - 200.0, y: view.center.y - 100.0, width: 400.0, height: 200.0)
    carouselView = SwiftCarousel(frame: carouselFrame)
    try! carouselView.itemsFactory(itemsCount: 5) { choice in
    let imageView = UIImageView(image: UIImage(named: "puppy\(choice+1)"))
    imageView.frame = CGRect(origin: CGPointZero, size: CGSize(width: 200.0, height: 200.0))
    
    return imageView
    }
    carouselView.resizeType = .WithoutResizing(10.0)
    carouselView.delegate = self
    carouselView.defaultSelectedIndex = 2
    view.addSubview(carouselView)
}
