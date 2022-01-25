//
//  DetailViewModel.swift
//  AppItunes
//
//  Created by Nicolás López Cano on 4/1/22.
//

import Foundation
import UIKit

struct DetailViewModel {
    let discographies: Discography
    
    init(discographies: Discography) {
        self.discographies = discographies
    }
    
    var title: String {
        return discographies.collectionName ?? discographies.artistName!
    }
    
    var thumbnail: URL? {
        return discographies.thumbnail ?? URL(string: "http://lamiradadelreplicante.com/wp-content/uploads/2015/06/swift.jpg")
    }
    
    var year: String? {
        guard let year = discographies.releaseDate else {
            return "Date"
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
