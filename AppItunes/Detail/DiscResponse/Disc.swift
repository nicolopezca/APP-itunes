//
//  Discography.swift
//  AppItunes
//
//  Created by Nicolás López Cano on 5/1/22.
//

import Foundation

struct Disc: Decodable {
    let artistId: Int?
    let artistName: String?
    let discCount: Int?
    let discNumber: Int?
    let primaryGenreName: String?
    let collectionName: String?
    let releaseDate: Date?
    let thumbnail: URL?
    let country: String?
    let wrapperType: String?
    
    enum CodingKeys: String, CodingKey {
        case artistId = "artistId"
        case artistName = "artistName"
        case discCount = "discCount"
        case discNumber = "discNumber"
        case primaryGenreName = "primaryGenreName"
        case collectionName = "collectionName"
        case releaseDate = "releaseDate"
        case thumbnail = "artworkUrl100"
        case country = "country"
        case wrapperType = "wrapperType"
    }
}
