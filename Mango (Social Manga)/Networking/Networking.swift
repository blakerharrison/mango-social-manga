//
//  Networking.swift
//  Mango (Social Manga)
//
//  Created by Blake Harrison on 8/16/18.
//  Copyright © 2018 Blake Harrison. All rights reserved.
//

// https://www.mangaeden.com/api/list/0/ List of all manga in JSON
// let mangaEdenURL = "https://www.mangaeden.com/api"

import UIKit
import SwiftyJSON
import SDWebImage

public var imageStringForCover: String = ""

//Manga list - https://www.mangaeden.com/api/list/0/

class MangoNetworking {
    
    var isMangaDetailBeingViewed = false
    
    //MARK: - Properties
    let mangaImageURL = "https://cdn.mangaeden.com/mangasimg/"
    let mangaURL = "https://www.mangaeden.com/api/manga/"
    let mangaChapterURL = "https://www.mangaeden.com/api/chapter/"
    
    var fetchedPagesURLs: Array<String> = []
    var fetchedPagesNumbers: Array<String> = []
    
    //MARK: - Methods
    func fetchMangaTitles(searchedManga: String) {
        
        resultsArray.removeAll()
        guard let url = URL(string: "https://www.mangaeden.com/api/list/0/") else {return}
        
        let searchedMangaLowercased = searchedManga.lowercased().replacingOccurrences(of: " ", with: "-", options: .literal, range: nil)
        print(searchedMangaLowercased)
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
           
            guard ReachabilityTest.isConnectedToNetwork() else {
                print("No internet connection available")
                myFetchTitlesGroup.leave()
                return
            }
                        
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            do{
                //here dataResponse received from a network request
                _ = try JSONSerialization.jsonObject(with:
                    dataResponse, options: [])
                
                let decoder = JSONDecoder()
                
                let listOfMangas = try decoder.decode(MangaList.self, from: data!)

                var filteredManga = listOfMangas.manga.filter { ($0.a!.contains(searchedMangaLowercased)) }
                
                filteredManga.sort {
                    return $0.h! > $1.h!
                }
                
                searchedMangaList = filteredManga

                if filteredManga.count != 0 {
      
                    for n in 0...filteredManga.count - 1 {
                
                        resultsArray.append(filteredManga[n].t!)
                    }

                    myFetchTitlesGroup.leave()
                    
                } else {
                    print("Manga Not Found")
                    myFetchTitlesGroup.leave()
                }
                
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
    
    //Fetches the chapters details based on ID.
    func fetchChapterDetails(chapterID: String) {
        let url = URL(string: mangaURL + chapterID)
        
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            
            do {
                if let json = try? JSON(data: data) {
                    
                    let updatedStringDiscription = json["description"].string!.replacingOccurrences(of: "&rsquo;", with: "'", options: .literal, range: nil).replacingOccurrences(of: "&#039;", with: "'", options: .literal, range: nil).replacingOccurrences(of: "&ndash;", with: "-", options: .literal, range: nil).replacingOccurrences(of: "&ldquo;", with: "\"", options: .literal, range: nil).replacingOccurrences(of: "&rdquo;", with: "\"", options: .literal, range: nil).replacingOccurrences(of: "&#333;", with: "o", options: .literal, range: nil).replacingOccurrences(of: "&quot;", with: "\"").replacingOccurrences(of: "%27", with: "'", options: .literal, range: nil).replacingOccurrences(of: "&#39;", with: "'", options: .literal, range: nil)
                    
                    var status = ""
                    
                    if json["status"].int! == 1 {
                        status = "Ongoing"
                        
                        currentManga = MangaDetails(name: json["title"].stringValue,
                                                    author: json["author"].stringValue,
                                                    category: json["categories"][0].stringValue,
                                                    released: json["released"].stringValue,
                                                    description: updatedStringDiscription,
                                                    imageURL: self.mangaImageURL + json["image"].stringValue,
                                                    status: status, id: chapterID)
                        
                    } else if json["status"].int! == 2 {
                        status = "Completed"
                        
                        currentManga = MangaDetails(name: json["title"].stringValue,
                                                    author: json["author"].stringValue,
                                                    category: json["categories"][0].stringValue,
                                                    released: json["released"].stringValue,
                                                    description: updatedStringDiscription,
                                                    imageURL: self.mangaImageURL + json["image"].stringValue,
                                                    status: status, id: chapterID)
                    } else {
                        status = "Unknown"
                        
                        currentManga = MangaDetails(name: json["title"].stringValue,
                                                    author: json["author"].stringValue,
                                                    category: json["categories"][0].stringValue,
                                                    released: json["released"].stringValue,
                                                    description: updatedStringDiscription,
                                                    imageURL: self.mangaImageURL + json["image"].stringValue,
                                                    status: status, id: chapterID)
                    }
                    
                    
                }
                
                NotificationCenter.default.post(name: NSNotification.Name.ChapterDetailsWereFetched, object: nil)
            }
            
        }).resume()
    }
    
    //Fetches the chapters properties.
    func fetchChapters(mangaID: String) {
        isMangaDetailBeingViewed = true
        
        let url = URL(string: mangaURL + mangaID)
        
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            
            do {
                if let json = try? JSON(data: data) {
                   
                    for i in json["chapters"].arrayValue {
                        chapterArray.append(MangaChapter(number: i[0].stringValue, title: i[2].stringValue, id: i[1].stringValue, chapterPath: i[3].stringValue))
                    }

                    NotificationCenter.default.post(name: NSNotification.Name.ChapterWasAppended, object: nil)
                }
            }
        }).resume()
    }
    
    //Fetch page numbers and image urls
    func fetchPages(chapterID: String) {
        
        print("FETCHING PAGES")
        print(chapterID)
        
        let url = URL(string: mangaChapterURL + chapterID)
        
        print("URL \(String(describing: url))")
        
        URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
            
            print("WE OOUT HERE")
            
            guard let data = data, error == nil else { print("No data")
                return }
            
            do {
                if let json = try? JSON(data: data) {
                    
                    print("")
                    print("IMAGES FROM SELECTED CHAPTER! ====== \(json["images"][0][0].int!)")
                    print("")
                    
                    for i in 0..<json["images"].count {
                    self.printPageValues(i: i, json: json)
                     
                    pages.append(PageOfChapter(pageNumber: json["images"][i][0].int!, imageURL: json["images"][i][1].stringValue))
                    }
                    
                    print(pages)
                    NotificationCenter.default.post(name: NSNotification.Name("load"), object: nil)
                    
                }
            }
            
        }).resume()
        
    }
    
    func printChapterValues(i: Int, json: JSON) {
        print("")
        print("Number -> \(json["chapters"][i][0].intValue)")
        print("Date -> \(NSDate(timeIntervalSince1970: json["chapters"][i][1].doubleValue))")
        print("Title -> \(json["chapters"][i][2].stringValue)")
        print("ID -> \(json["chapters"][i][3].stringValue)")
    }
    
    func printPageValues(i: Int, json: JSON) {
        print("")
        print("Page number -> \(json["images"][i][0].intValue)")
        print("URL end point -> \(json["images"][i][1].stringValue)")
    }
    
    
}
