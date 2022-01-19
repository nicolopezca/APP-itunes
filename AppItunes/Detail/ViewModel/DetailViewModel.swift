//
//  DetailViewModel.swift
//  AppItunes
//
//  Created by Nicolás López Cano on 4/1/22.
//

import Foundation
import UIKit

struct DetailViewModel {
    let thumbnail: URL?
    let title: String?
    var year: String?
}

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
