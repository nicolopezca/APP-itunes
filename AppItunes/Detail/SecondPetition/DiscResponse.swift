//
//  DiscoResponse.swift
//  AppItunes
//
//  Created by Nicolás López Cano on 5/1/22.
//

import Foundation

struct DiscResponse: Decodable {
    var discs: [Discography]
    var resultCount: Int
    
    enum CodingKeys: String, CodingKey {
        case resultCount = "resultCount"
        case discs = "results"
    }    
}
