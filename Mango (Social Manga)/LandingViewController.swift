//
//  LandingViewController.swift
//  Mango (Social Manga)
//
//  Created by Blake Harrison on 4/8/18.
//  Copyright © 2018 Blake Harrison. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {
    
    var pref: UserDefaults = UserDefaults.standard
    
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
        
        pref.set(nil, forKey: "Naruto")
        pref.synchronize()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        naruto.isUserInteractionEnabled = true
        naruto.addGestureRecognizer(tapGestureRecognizer)
        
        naruto.addShadow()
        onePiece.addShadow()
        bleach.addShadow()
        
        self.navigationController?.navigationBar.isHidden = true;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
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
        
//        pref.set(109088, forKey: "Naruto")
//        pref.synchronize()
//
//        performSegue(withIdentifier: "naruto", sender: nil)
        
        //Placeholder ALERT
        let alertController = UIAlertController(title: "Chapter 1 or 2?", message: "", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "1", style: .cancel) { action in
            
            self.pref.set(109088, forKey: "Naruto")
            self.pref.synchronize()
            
            self.performSegue(withIdentifier: "naruto", sender: nil)
            
        }
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "2", style: .default) { action in
            
            self.pref.set(109089, forKey: "Naruto")
            self.pref.synchronize()
            
            self.performSegue(withIdentifier: "naruto", sender: nil)
            
        }
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true) {
            // ...
        }
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
