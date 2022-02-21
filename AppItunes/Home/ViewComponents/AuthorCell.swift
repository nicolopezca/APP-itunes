//
//  AuthorCell.swift
//  AppItunes
//
//  Created by Nicolás López Cano on 14/12/21.
//

import UIKit

class AuthorCell: UITableViewCell {
    @IBOutlet private weak var labelsStack: UIStackView!
    static let cellReuseIdentifier = String(describing: AuthorCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.labelsStack.subviews.forEach { $0.removeFromSuperview() }
    }
    
    func setViewModel(_ viewModel: ArtistViewModel) {
        addAllLabels(viewModel)
    }
    
    func addLabel(_ text: String, font: UIFont) {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = text
        label.font = font
        labelsStack.addArrangedSubview(label)
    }
    
    func addAllLabels(_ viewModel: ArtistViewModel) {
        addAuthorLabel(viewModel.author)
        addStyleLabel(viewModel.style)
        addDiscographyLabel()
        addDiscLabel(viewModel.disc)
        addExtendedLabel()
    }
}

extension AuthorCell {
    
    func addAuthorLabel(_ author: String) {
        if let boldFont = UIFont(name: "HelveticaNeue-Bold", size: 16.0) {
            addLabel(author, font: boldFont)
        } else {
            addLabel(author, font: UIFont.systemFont(ofSize: 14))
        }
    }
    
    func addStyleLabel(_ style: String) {
        addLabel(style, font: UIFont.italicSystemFont(ofSize: 14.0))
    }
    
    func addDiscographyLabel() {
        if let boldFont = UIFont(name: "HelveticaNeue-Bold", size: 16.0) {
            addLabel(NSLocalizedString("Discography", comment: ""), font: boldFont)
        } else {
            addLabel(NSLocalizedString("Discography", comment: ""), font: UIFont.systemFont(ofSize: 14))
        }
    }
    
    func addDiscLabel(_ disc: String) {
        addLabel(disc, font: UIFont.systemFont(ofSize: 14))
    }
    
    func  addExtendedLabel() {
        addLabel(NSLocalizedString("Extended", comment: ""), font: UIFont.italicSystemFont(ofSize: 14.0))
    }
}
