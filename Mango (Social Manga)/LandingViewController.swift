//
//  LandingViewController.swift
//  Mango (Social Manga)
//
//  Created by Blake Harrison on 4/8/18.
//  Copyright © 2018 Blake Harrison. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var naruto: UIImageView!
    @IBOutlet weak var onePiece: UIImageView!
    @IBOutlet weak var bleach: UIImageView!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //MARK: Lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        naruto.isUserInteractionEnabled = true
        naruto.addGestureRecognizer(tapGestureRecognizer)
        
        naruto.addShadow()
        onePiece.addShadow()
        bleach.addShadow()
        
        self.navigationController?.navigationBar.isHidden = true;
    }
    
    //MARK: Functions
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        _ = tapGestureRecognizer.view as! UIImageView
        
        performSegue(withIdentifier: "naruto", sender: nil)
    }
}

//MARK: Extensions
extension UIView {
    
    func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.75
        layer.shadowRadius = 5
        clipsToBounds = false
    }
}
