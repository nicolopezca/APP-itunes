//
//  CompletedViewModel.swift
//  AppItunes
//
//  Created by Nicolás López Cano on 15/12/21.
//

import Foundation
struct ArtistViewModel {
    let author: String?
    let style: String?
    let discography: String?

    init(author: String, style: String, discography: String? = nil) {
        self.author = author
        self.style = style
        self.discography = discography
    }
//    
//    var firstDisc: String? {
//        guard let discography = discography else { return nil }
//        return discography[0]
//    }
//    
//    var secondDisk: String? {
//        guard let discography = discography, discography.count > 1 else { return nil }
//        return discography[1]    
//    }
//    
    var hasMoreThanTwo: Bool {
        guard let discography = discography else { return false }
        return discography.count > 2
    }
}
