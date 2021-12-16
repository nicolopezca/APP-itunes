//
//  AuthorCell.swift
//  AppItunes
//
//  Created by Nicolás López Cano on 14/12/21.
//

import UIKit

class AuthorCell: UITableViewCell {
    @IBOutlet private weak var labelsStack: UIStackView!
    static let cellReuseIdentifier = "AuthorCell"

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setViewModel(_ viewModel: CompletedViewModel) {
        if let author = viewModel.author {
            addLabel(author)
        }
        if let style = viewModel.style {
            addLabel(style)
        }
        if let firstDisk = viewModel.firstDisc {
            let discografia = "Discografia"
            addLabel(discografia)
            addLabel(firstDisk)
        }
        if let secondDisk = viewModel.secondDisk{
            addLabel(secondDisk)
        }
        if viewModel.hasMoreThanTwo {
            let extendedLabel = "..."
            addLabel(extendedLabel)
        }
    }
    
    func addLabel(_ text: String) {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = text
        labelsStack.addArrangedSubview(label)
    }
}
