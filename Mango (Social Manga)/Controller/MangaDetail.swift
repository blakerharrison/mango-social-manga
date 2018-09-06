//
//  MangaDetail.swift
//  Mango (Social Manga)
//
//  Created by Blake Harrison on 9/6/18.
//  Copyright © 2018 Blake Harrison. All rights reserved.
//

import UIKit

var selectedIndex = 0

class MangaDetail: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var mangaImage: UIImageView!
    @IBOutlet weak var mangaTitle: UILabel!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        print(searchedMangaList[selectedIndex].t!)
        
        mangaTitle.text = searchedMangaList[selectedIndex].t!
        
//        mangaTitle.text = filtere
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        selectedIndex = 0
    }

}
