//
//  MangaInfoAndChapterList.swift
//  Mango (Social Manga)
//
//  Created by Blake Harrison on 9/6/18.
//  Copyright © 2018 Blake Harrison. All rights reserved.
//

import Foundation

struct MangaInfoAndChapterList: Decodable {
    let aka: [String]
//    let aka-alias: [String]
    let alias: String?
    let artist: String?
    let artist_kw: [String?]
    let author: String?
    let author_kw: [String?]
    let baka: Bool?
    let categories: [String?]
    let chapters: [[MetadataType?]]
    let chapters_len: Int?
    let created: Int?
    let description: String?
    let hits: Int?
    let image: String?
    let imageURL: String?
    let language: Int?
    let last_chapter_date: Int?
//    let random: []
    let released: Int?
    let startsWith: String?
    let status: Int?
    let title: String?
    let title_kw: [String?]
    let type: Int?
    let updatedKeywords: Bool?
}

enum MetadataType: Decodable {
    case float(Float)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            self = try .float(container.decode(Float.self))
        } catch DecodingError.typeMismatch {
            do {
                self = try .string(container.decode(String.self))
            } catch DecodingError.typeMismatch {
                throw DecodingError.typeMismatch(MetadataType.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Encoded payload not of an expected type"))
            }
        }
}
}
