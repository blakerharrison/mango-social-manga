//
//  HTTPRequests.swift
//  Mango (Social Manga)
//
//  Created by Blake Harrison on 4/8/18.
//  Copyright © 2018 Blake Harrison. All rights reserved.
//

import UIKit

public class MangaPageViewController: UIViewController {
    
/// A function that impliments a GET request to show an image.
///
/// - Parameters:
///   - theUrl: A URL.
///   - theImageView: Where the image will appear.
public func loadImage(theUrl: String, theImageView: UIImageView){

    guard let url = URL(string: theUrl) else { return }
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
            theImageView.image = UIImage(data: data!)
        }
        }.resume()
    }
}
