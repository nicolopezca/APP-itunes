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
        addBoldLabel(viewModel.author)
        addItalicLabel(viewModel.style)
        addBoldLabel(NSLocalizedString("Discography", comment: ""))
        // TODO: - review discs labels
        addLabel(viewModel.disc)
        //            addLabel(viewModel.disc1)
        //            addLabel(viewModel.disc2)
        //        if viewModel.hasMoreThanTwoDiscs {
        addItalicLabel(NSLocalizedString("Extended", comment: ""))
        //        }
    }
    
    func addLabel(_ text: String) {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = text
        labelsStack.addArrangedSubview(label)
    }
    
    func addBoldLabel(_ text: String) {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = text
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        labelsStack.addArrangedSubview(label)
    }
    
    func addItalicLabel(_ text: String) {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = text
        label.font = UIFont.italicSystemFont(ofSize: 14.0)
        labelsStack.addArrangedSubview(label)
    }
}
