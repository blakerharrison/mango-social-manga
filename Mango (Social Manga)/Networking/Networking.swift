//
//  Networking.swift
//  Mango (Social Manga)
//
//  Created by Blake Harrison on 8/16/18.
//  Copyright © 2018 Blake Harrison. All rights reserved.
//

// https://www.mangaeden.com/api/list/0/ List of all manga in JSON
// let mangaEdenURL = "https://www.mangaeden.com/api"

import Foundation

//Manga list - https://www.mangaeden.com/api/list/0/

struct MangaList: Codable {
    let end: Int
    let manga: [manga]
    let page: Int
    let start: Int
    let total: Int
}

struct manga: Codable {
    let a: String?
    let c: [String]?
    let h: Int?
    let i: String?
    let im: String?
    let ld: Int?
    let s: Int?
    let t: String?
}

func fetchJSON() {
    guard let url = URL(string: "https://www.mangaeden.com/api/list/0/") else {return}
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let dataResponse = data,
            error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                return }
        do{
            //here dataResponse received from a network request
            let jsonResponse = try JSONSerialization.jsonObject(with:
                dataResponse, options: []) 
            print(jsonResponse) //Response result
            
            let decoder = JSONDecoder()
            let product = try decoder.decode(MangaList.self, from: data!)
            
            print("Print manga")
            print(product.manga.filter { $0.t! == "Bleach" })
            
            
            
            
            
        } catch let parsingError {
            print("Error", parsingError)
        }
    }
    task.resume()
}


