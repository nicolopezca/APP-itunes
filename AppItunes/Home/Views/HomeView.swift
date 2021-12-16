//
//  HomeViewController.swift
//  AppItunes
//
//  Created by Nicolás López Cano on 14/12/21.
//

import UIKit

class HomeView: UIView, UITableViewDelegate, UITableViewDataSource {
    private var viewModels: [CompletedViewModel] = []
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
        initSubView()
        configureTable()
        createMockViewModels()
    }
    
    func initSubView() {
        Bundle.main.loadNibNamed("HomeView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
    }

    func createMockViewModels() {
        let discography3: [String] = ["disco1", "disco2", "disco3"]
        let discography2: [String] = ["disco1", "disco2"]
        let discography1: [String] = ["disco4"]
        let mockViewModel1 = CompletedViewModel(author: "Pepe", style: "rock", discography: discography2)
        let mockViewModel2 = CompletedViewModel(author: "Pepe", style: "pop")
        let mockViewModel3 = CompletedViewModel(author: "Pepe", style: "rock", discography: discography3)
        let mockViewModel4 = CompletedViewModel(author: "Pepe", style: "rock", discography: discography1)
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
