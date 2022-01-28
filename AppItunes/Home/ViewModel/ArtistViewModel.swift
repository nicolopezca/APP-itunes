//
//  CompletedViewModel.swift
//  AppItunes
//
//  Created by Nicolás López Cano on 15/12/21.
//

import Foundation

struct ArtistViewModel {
    let artist: Artist
    
    init(artist: Artist) {
        self.artist = artist
    }
    
    var author: String {
        return artist.artistName ?? ""
    }
    
    var id: Int {
        return artist.artistId ?? 0
    }
    
    var style: String {
        return artist.primaryGenreName ?? ""
    }
    
    var discography: String {
        return artist.collectionName ?? ""
    }
    
    var hasMoreThanTwoDiscs: Bool {
        guard let discography = artist.collectionName else { return false }
        return discography.count > 2
    }
}
