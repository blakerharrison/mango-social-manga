//
//  Home.swift
//  Mango (Social Manga)
//
//  Created by Blake Harrison on 8/17/18.
//  Copyright © 2018 Blake Harrison. All rights reserved.
//

import UIKit

var mangaTitles = ["Naruto", "One Piece", "Bleach"]

class Home: UIViewController {

    //MARK: - Properties

    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    
    
}

//MARK: - Extensions
extension UIViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mangaTitles.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath)
        
        let book = mangaTitles[indexPath.row]
        cell.textLabel?.text = book
        
        return cell
    }
    
}

////MARK: - Methods
//func setImage() {
//    //        print("URL for image: \(imageStringForCover)")
//
//    guard let url = URL(string: imageStringForCover) else { return }
//    URLSession.shared.dataTask(with: url) { (data, response, error) in
//        if error != nil {
//            print("Failed fetching image:", error!)
//            return
//        }
//
//        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//            print("Not a proper HTTPURLResponse or statusCode")
//
//            let alert = UIAlertController(title: "Connection Error", message: "404", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//            self.present(alert, animated: true)
//            return
//        }
//
//        DispatchQueue.main.async {
//            self.imageView.image = UIImage(data: data!)
//        }
//        }.resume()
//}
