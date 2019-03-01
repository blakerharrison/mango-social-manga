//
//  Home.swift
//  Mango (Social Manga)
//
//  Created by Blake Harrison on 8/17/18.
//  Copyright © 2018 Blake Harrison. All rights reserved.
//

import UIKit

class Home: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var homeView: UIView!
    
    let YEET = [MangaObject(mangaCover: UIImage(named: "RalGrad"), mangaTitles: "Ral Grad")]
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
}

extension Home: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return YEET.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        var mangaCoverImage = UIImageView()
        
        mangaCoverImage = cell.viewWithTag(1000) as! UIImageView
 
        mangaCoverImage.image = YEET[indexPath.row].mangaCover
        
        return cell
    }
    
    
}

