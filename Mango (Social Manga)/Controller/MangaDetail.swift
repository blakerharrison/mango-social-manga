//
//  MangaDetail.swift
//  Mango (Social Manga)
//
//  Created by Blake Harrison on 9/6/18.
//  Copyright © 2018 Blake Harrison. All rights reserved.
//

import UIKit
import SwiftyJSON

var selectedIndex = 0
var selectedID = ""

class MangaDetail: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var mangaChapters: [[MetadataType?]] = [[]]
    var mangaChaptersString: [String] = []
    
    //MARK: - Outlets
    @IBOutlet weak var mangaImage: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var mangaDescription: UITextView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

//        setImage()
        mangaImage.addShadow()
        
        fetchMangaInfo(mangaID: selectedID) //TODO: TEST

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
    
    func fetchMangaInfo(mangaID: String) {
        
        guard let url = URL(string: "https://www.mangaeden.com/api/manga/" + mangaID) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            do{
                //here dataResponse received from a network request
                _ = try JSONSerialization.jsonObject(with:
                    dataResponse, options: [])
                
                let decoder = JSONDecoder()
                
                let mangaInfo = try decoder.decode(MangaInfoAndChapterList.self, from: data!)
                
                let json = try JSON(data: data!)
                
                DispatchQueue.main.async {
                    
                    self.setImage()
                    
                self.mangaDescription.text = json["description"].string!
                self.authorLabel.text = json["author"].string!
                    
                if json["status"].int! == 1 {
                    self.statusLabel.text = "Status: ongoing"
                } else if json["status"].int! == 2 {
                    self.statusLabel.text = "Status: completed"
                }
                    
                    self.mangaChapters = mangaInfo.chapters
                    
                    self.mangaChaptersString.removeAll()
                    
                    for n in 0...mangaInfo.chapters.count - 1{
                        let chapters = json["chapters"][n].array
                        self.mangaChaptersString.append(chapters![0].stringValue)
                    }
                    
                    self.tableView.reloadData()
                    
                }
                
                
                
                
                print(self.mangaChaptersString)
                
//                DispatchQueue.main.async {
//
//                }
                
                
                
                
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
    
    //MARK: - Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mangaChapters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chapters", for: indexPath)
        
        if let label = cell.viewWithTag(1000) as? UILabel
        {
            if mangaChaptersString.isEmpty {
                
            } else {
                label.text = "Chapter: " + mangaChaptersString[indexPath.row]
            }
            
        }
        
        return cell
    }
    
}

