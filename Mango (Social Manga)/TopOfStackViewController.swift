//
//  TopOfStackViewController.swift
//  Mango (Social Manga)
//
//  Created by Blake Harrison on 4/19/18.
//  Copyright © 2018 Blake Harrison. All rights reserved.
//

import UIKit

class TopOfStackViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidAppear(_ animated: Bool) {
         performSegue(withIdentifier: "openBook", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
}
