//
//  Results.swift
//  AppItunes
//
//  Created by Nicolás López Cano on 16/12/21.
//
import Foundation

struct Artist: Decodable {
    let artistId: Int?
    let artistName: String?
    let discCount: Int?
    let discNumber: Int?
    let primaryGenreName: String?
    let collectionName: String?
}
