//
//  DetailViewController.swift
//  AppItunes
//
//  Created by Nicolás López Cano on 5/1/22.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet private weak var detailView: DetailView!
    var artist: Artist?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle()
        getDiscography()
    }
}
private extension DetailViewController {
    func setTitle() {
        self.title = artist?.artistName
    }
    
    func getDiscography() {
        guard let id = artist?.artistId else { return }
        detailView.getDiscographyFromId(id)
    }
}
