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
        addLabel(viewModel.author)
        addLabel(viewModel.style)
        addLabel(NSLocalizedString("Discography", comment: ""))
        addLabel(viewModel.discography)
        if viewModel.hasMoreThanTwoDiscs {
            addLabel(NSLocalizedString("Extended", comment: ""))
        }
    }
    
    func addLabel(_ text: String) {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = text
        labelsStack.addArrangedSubview(label)
    }
}
