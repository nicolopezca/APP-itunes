//
//  DetailCell.swift
//  AppItunes
//
//  Created by Nicolás López Cano on 4/1/22.
//

import UIKit

class DetailCell: UITableViewCell {
    static let cellReuseIdentifier = "DetailCell"
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setViewModel(_ viewModel: DetailViewModel) {
        titleLabel.text = viewModel.title
        yearLabel.text = viewModel.year
        self.albumImage?.loadImageFromUrl(url: viewModel.thumbnail!, completion: nil)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
