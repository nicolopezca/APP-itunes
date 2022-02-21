//
//  DetailViewModel.swift
//  AppItunes
//
//  Created by Nicolás López Cano on 4/1/22.
//

import Foundation
import UIKit

struct DetailViewModel {
    private enum Constants {
        static let defaultImageURL = "http://lamiradadelreplicante.com/wp-content/uploads/2015/06/swift.jpg"
    }
    let discography: Disc
    
    init(discography: Disc) {
        self.discography = discography
    }
    
    var title: String {
        return discography.collectionName ?? ""
    }
    
    var thumbnail: URL? {
        return discography.thumbnail ?? URL(string: Constants.defaultImageURL)
    }
    
    var year: String? {
        guard let year = discography.releaseDate else {
            return nil
        }
        return year.getFormattedDate(format: "yyyy")
    }
}

extension Date {
    func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
