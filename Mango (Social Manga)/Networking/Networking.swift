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

public var imageStringForCover: String = ""

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

class MangoNetworking {
    
    //MARK: - Properties
    let mangaImageURL = "https://cdn.mangaeden.com/mangasimg/"
    
    //MARK: - Methods
    func fetchJSON(search: String) {
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
//                print(jsonResponse) //Response result
                
                let decoder = JSONDecoder()
                let listOfMangas = try decoder.decode(MangaList.self, from: data!)
                
                print("Print manga")
                
                let searchedManga = search //TODO: Will be replaced with a search bar feature for the user
                
                //let filteredManga = product.manga.filter { $0.a! == searchedManga }
                 let filteredManga = listOfMangas.manga.filter { $0.t! == searchedManga }

//                print(type(of: filteredManga))
//
//                print(filteredManga.map { $0.im! }) // Used to get the values from the filtered manga using map
                
                
                let mangaImagePath = filteredManga.map { $0.im! }
                let mangaImageEndpoint = self.mangaImageURL + mangaImagePath[0]
                
                print(mangaImageEndpoint)

                imageStringForCover = mangaImageEndpoint
                
                print("1")
                
                
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
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
