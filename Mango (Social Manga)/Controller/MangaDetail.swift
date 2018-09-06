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
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setImage()
    
        navigationItem.title = searchedMangaList[selectedIndex].t!
        
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedStringKey.font: UIFont(name: "BigNoodleTitling", size: 21)!]
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        selectedIndex = 0
    }

    //MARK: - Methods
    func setImage() {
        
        guard searchedMangaList[selectedIndex].im != nil else {
            print("No Image")
            return
        }
        
        guard let url = URL(string: "https://cdn.mangaeden.com/mangasimg/" + searchedMangaList[selectedIndex].im!) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("Failed fetching image:", error!)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Not a proper HTTPURLResponse or statusCode")
                
                let alert = UIAlertController(title: "Connection Error", message: "404", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
                return
            }
            
            DispatchQueue.main.async {
                self.mangaImage.image = UIImage(data: data!)
            }
            }.resume()
    }
    
}
