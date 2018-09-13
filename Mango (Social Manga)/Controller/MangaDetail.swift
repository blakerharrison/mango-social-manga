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
var selectedChapterID = ""

class MangaDetail: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Properties
    let Networking = MangoNetworking()
    var mangaChapters: [[MetadataType?]] = [[]]
    var mangaChaptersString: [String] = []
    var mangaChapterIDs: [String] = []
    
    //MARK: - Outlets
    @IBOutlet weak var mangaImage: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var mangaDescription: UITextView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var releasedLabel: UILabel!
    @IBOutlet weak var readButton: UIButton!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
 
        fetchMangaInfo(mangaID: selectedID)
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedStringKey.font: UIFont(name: "BigNoodleTitling", size: 21)!]
        navigationItem.title = searchedMangaList[selectedIndex].t!
        mangaImage.addShadow()
        readButton.layer.cornerRadius = 5
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        selectedIndex = 0
    }

    //MARK: - Methods
    fileprivate func setUIDetails(_ json: JSON, _ mangaInfo: MangaInfoAndChapterList) {
        DispatchQueue.main.async {
            
            let updatedStringDiscription = json["description"].string!.replacingOccurrences(of: "&rsquo;", with: "'", options: .literal, range: nil).replacingOccurrences(of: "&#039;", with: "'", options: .literal, range: nil).replacingOccurrences(of: "&ndash;", with: "-", options: .literal, range: nil).replacingOccurrences(of: "&ldquo;", with: "\"", options: .literal, range: nil).replacingOccurrences(of: "&rdquo;", with: "\"", options: .literal, range: nil).replacingOccurrences(of: "&#333;", with: "o", options: .literal, range: nil).replacingOccurrences(of: "&quot;", with: "\"")
            
            self.fetchImage()
            self.mangaDescription.text = updatedStringDiscription
            self.authorLabel.text = json["author"].string!
            self.categoriesLabel.text = "category: " + json["categories"][0].stringValue
            self.releasedLabel.text = "released: " + json["released"].stringValue
            
            print(json["chapters"][0][3])
            
            if json["status"].int! == 1 {
                self.statusLabel.text = "Status: ongoing"
            } else if json["status"].int! == 2 {
                self.statusLabel.text = "Status: completed"
            }
            
            self.mangaChapters = mangaInfo.chapters
            
            self.mangaChaptersString.removeAll()
            self.mangaChapterIDs.removeAll()
            
            for n in 0...mangaInfo.chapters.count - 1{
                let chapters = json["chapters"][n].array
                self.mangaChaptersString.append(chapters![0].stringValue)
                self.mangaChapterIDs.append(chapters![3].stringValue)
            }
            self.tableView.reloadData()
        }
    }
    
    fileprivate func setUIImage(_ data: Data?) {
        DispatchQueue.main.async {
            self.mangaImage.image = UIImage(data: data!)
        }
    }
    
    //MARK: - Networking
    func fetchImage() { //TODO: Move to MangoNetworking
        
        guard searchedMangaList[selectedIndex].im != nil else {
            print("No Image")
            return
        }
        
        guard let url = URL(string: Networking.mangaImageURL + searchedMangaList[selectedIndex].im!) else { return }
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
            
            self.setUIImage(data)
            
            }.resume()
    }
    
    func fetchMangaInfo(mangaID: String) { //TODO: Move to MangoNetworking
        
        guard let url = URL(string: Networking.mangeListURL + mangaID) else {return}
        
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
                
                self.setUIDetails(json, mangaInfo)
                
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
    
    //MARK: - Actions
    
    //TODO: - Add an aciton button for Read. !@#$%^&*()
    
    //MARK: - Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mangaChapters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chapters", for: indexPath)
        
        if let label = cell.viewWithTag(1000) as? UILabel {
            if mangaChaptersString.isEmpty {
            } else {
                label.text = "Chapter: " + mangaChaptersString[indexPath.row]
            }
        }
        return cell
}
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedChapterID = mangaChapterIDs[indexPath.row]
        self.tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "readerSegue", sender: self)
    }
    
}

