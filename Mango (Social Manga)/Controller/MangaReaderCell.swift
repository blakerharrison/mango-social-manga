//
//  MangaReaderCell.swift
//  Mango (Social Manga)
//
//  Created by Blake Harrison on 10/15/18.
//  Copyright © 2018 Blake Harrison. All rights reserved.
//

import UIKit
import JGProgressHUD

// MARK: - Custom Cell
class MangaReaderCell: UICollectionViewCell, UIScrollViewDelegate {

    @IBOutlet weak var pageImage: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func prepareForReuse() {
        super.prepareForReuse()

        self.pageImage.image = UIImage()

        self.scrollView.zoomScale = 1
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
            
            let rect = CGRect(origin: CGPoint(x: x, y: y), size: CGSize(width: width, height: height))
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
