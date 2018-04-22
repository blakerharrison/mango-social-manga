//
//  TopOfStackViewController.swift
//  Mango (Social Manga)
//
//  Created by Blake Harrison on 4/19/18.
//  Copyright © 2018 Blake Harrison. All rights reserved.
//

import UIKit

class TopOfStackViewController: UIViewController {

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    let pref: UserDefaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidAppear(_ animated: Bool) {
        
        guard pref.bool(forKey: "AutoTransition") == true else {
            let  vc =  self.navigationController?.viewControllers.filter({$0 is LandingViewController}).first
            self.navigationController?.popToViewController(vc!, animated: true)
     
            return
        }
        performSegue(withIdentifier: "openBook", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
    
//    public func automaticLoadBook(auto: Bool) {
//        guard auto == true else {
//            return print("Not automatic")
//        }
//        performSegue(withIdentifier: "openBook", sender: self)
//    }
}


