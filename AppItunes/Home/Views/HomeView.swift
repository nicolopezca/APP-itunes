//
//  HomeViewController.swift
//  AppItunes
//
//  Created by Nicolás López Cano on 14/12/21.
//

import UIKit

class HomeView: UIView, UITableViewDelegate, UITableViewDataSource {
    var viewModels: [ItunesAuthorViewModel] = []
    @IBOutlet weak var homeTableView: UIView!
    @IBOutlet weak var authorTableView: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("HomeViewController", owner: self, options: nil)
        addSubview(homeTableView)
        homeTableView.frame = self.bounds
//        homeTableView.autoresizingMask [.flexibleHeight, .flexibleWidth]
        let nib = UINib(nibName: "AuthorCell", bundle: nil)
        authorTableView.register(nib, forCellReuseIdentifier: AuthorCell.cellReuseIdentifier)
        authorTableView.delegate = self
        authorTableView.dataSource = self
        createMockViewModels()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AuthorCell = self.authorTableView.dequeueReusableCell(withIdentifier: AuthorCell.cellReuseIdentifier) as! AuthorCell
        cell.setViewModel(viewModels[indexPath.row])
        return cell
    }
}

private extension HomeTableView {
    func createMockViewModels() {
        let mockViewModel1 = ItunesAuthorViewModel(author: "Name: Bruno Mars", style: "Style: pop")
        let mockViewModel2 = ItunesAuthorViewModel(author: "Name: Nirvana", style: "Style: punk")
        let mockViewModel3 = ItunesAuthorViewModel(author: "Name: Daft punk", style: "Style: electronic")
        let mockViewModel4 = ItunesAuthorViewModel(author: "Name: Drake", style: "Style: rap")
        viewModels.append(mockViewModel1)
        viewModels.append(mockViewModel2)
        viewModels.append(mockViewModel3)
        viewModels.append(mockViewModel4)
    }
}
