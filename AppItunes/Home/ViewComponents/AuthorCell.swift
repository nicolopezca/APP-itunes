//
//  AuthorCell.swift
//  AppItunes
//
//  Created by Nicolás López Cano on 14/12/21.
//

import UIKit

class AuthorCell: UITableViewCell {

    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var styleLabel: UILabel!
    static let cellReuseIdentifier = "SunsetTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setViewModel(_ viewModel: ItunesAuthorViewModel) {
        self.authorLabel.text = viewModel.author
        self.styleLabel.text = viewModel.style
        self.authorLabel.numberOfLines = 0
        self.styleLabel.numberOfLines = 0
    }
}
