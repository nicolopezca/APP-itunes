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
    let id: Int?

    init(author: String, style: String, discography: String? = nil, id: Int?) {
        self.author = author
        self.style = style
        self.discography = discography
        self.id = id
    }

    var hasMoreThanTwo: Bool {
        guard let discography = discography else { return false }
        return discography.count > 2
    }
}
