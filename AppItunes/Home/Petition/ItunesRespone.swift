//
//  ItunesRespone.swift
//  AppItunes
//
//  Created by Nicolás López Cano on 16/12/21.
//

import Foundation

struct ItunesResponse: Decodable {
    var artists: [Artist]
    var resultCount: Int
    
    enum CodingKeys: String, CodingKey {
        case resultCount = "resultCount"
        case artists = "results"
    }
}
