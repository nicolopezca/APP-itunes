//
//  Discography.swift
//  AppItunes
//
//  Created by Nicolás López Cano on 5/1/22.
//

import Foundation
struct Discography: Decodable {
    let artistId: Int?
    let artistName: String?
    let discCount: Int?
    let discNumber: Int?
    let primaryGenreName: String?
    let collectionName: String?
    let releaseDate: Date?
    let artworkUrl100: URL?
    let country: String?
    
    enum CodingKeys: String, CodingKey {
        case artistId = "artistId"
        case artistName = "artistName"
        case discCount = "discCount"
        case discNumber = "discNumber"
        case primaryGenreName = "primaryGenreName"
        case collectionName = "collectionName"
        case releaseDate = "releaseDate"
        case artworkUrl100 = "artworkUrl100"
        case country = "country"
    }
}

