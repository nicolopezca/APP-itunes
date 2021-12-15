//
//  HomeViewController.swift
//  AppItunes
//
//  Created by Nicolás López Cano on 14/12/21.
//

import UIKit

class HomeView: UIView, UITableViewDelegate, UITableViewDataSource {
    private var viewModels: [ItunesAuthorViewModel] = []
    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: AuthorCell = self.tableView.dequeueReusableCell(withIdentifier: AuthorCell.cellReuseIdentifier) as? AuthorCell else {
            return UITableViewCell()
        }
        cell.setViewModel(viewModels[indexPath.row])
        return cell
    }
}

private extension HomeView {
     func commonInit() {
        initSubwiew()
        configureTable()
        createMockViewModels()
    }
    
    func initSubwiew() {
        Bundle.main.loadNibNamed("HomeView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
    }
    
    func createMockViewModels() {
        let mockViewModel1 = ItunesAuthorViewModel(author: "Name: Bruno Mars", style: "Style: pop")
        let mockViewModel2 = ItunesAuthorViewModel(author: "Name: Nirvana", style: "Style: punk")
        let mockViewModel3 = ItunesAuthorViewModel(author: "Name: Daft punk", style: "Style: electronic")
        let mockViewModel4 = ItunesAuthorViewModel(author: "Name: Drake", style: "Style: rap")
        viewModels.append(mockViewModel1)
        viewModels.append(mockViewModel2)
        viewModels.append(mockViewModel3)
        viewModels.append(mockViewModel4)
        tableView.reloadData()
    }
    
    func configureTable() {
        let nib = UINib(nibName: AuthorCell.cellReuseIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: AuthorCell.cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
}
