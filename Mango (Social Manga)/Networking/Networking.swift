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

public var imageStringForCover: String = ""

//Manga list - https://www.mangaeden.com/api/list/0/

class MangoNetworking {
    
    //MARK: - Properties
    let mangaImageURL = "https://cdn.mangaeden.com/mangasimg/"
    let mangeListURL = "https://www.mangaeden.com/api/manga/"
    let mangaChapterURL = "https://www.mangaeden.com/api/chapter/"
    
    //MARK: - Methods
    func fetchMangaTitles(searchedManga: String) {
        guard let url = URL(string: "https://www.mangaeden.com/api/list/0/") else {return}
        
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
                
                let listOfMangas = try decoder.decode(MangaList.self, from: data!)

                let filteredManga = listOfMangas.manga.filter { ($0.t?.contains(searchedManga))! }
                
                searchedMangaList = filteredManga
                
                if filteredManga.count != 0 {

                    resultsArray.removeAll()
                    
                    for n in 0...filteredManga.count - 1 {
                        resultsArray.append(filteredManga[n].t!)
                    }

                } else {
                    print("Manga Not Found")
                }

            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
}
