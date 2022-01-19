//
//  DetailViewController.swift
//  AppItunes
//
//  Created by Nicolás López Cano on 5/1/22.
//

import UIKit

class DetailViewController: UIViewController {
    var id: Int?
    var titleArtist: String?
    private lazy var detailView: DetailView = {
        let view = DetailView(frame: self.view.frame)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addDetailView()
        self.title = titleArtist
    }
    
    func addDetailView() {
        self.view.addSubview(detailView)
        detailView.obtainId(id: id!)
        detailView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        detailView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        detailView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        detailView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
}
