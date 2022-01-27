//
//  DetailViewModel.swift
//  AppItunes
//
//  Created by Nicolás López Cano on 4/1/22.
//

import Foundation
import UIKit

struct DetailViewModel {
    let discography: Discography
    
    init(discographies: Discography) {
        self.discography = discographies
    }
    
    var title: String {
        return discography.collectionName ?? ""
    }
    
    var thumbnail: URL? {
        return discography.thumbnail ?? URL(string: "http://lamiradadelreplicante.com/wp-content/uploads/2015/06/swift.jpg")
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
