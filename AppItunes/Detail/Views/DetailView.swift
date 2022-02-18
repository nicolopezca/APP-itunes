//
//  DetailView.swift
//  AppItunes
//
//  Created by Nicolás López Cano on 5/1/22.
//

import UIKit

class DetailView: UIView {
    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    private enum Constants {
        static let collection = "collection"
    }
    
    private var viewModels: [DetailViewModel] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func getDiscographyFromId(_ id: Int) {
        let request = AlbumCall(id: id)
        request.getDiscography { discs in
            self.obtainDetailData(discs)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

private extension DetailView {
    func commonInit() {
        initSubView()
        configureTable()
    }
    
    func obtainDetailData(_ discs: [Disc]?) {
        guard let discs = discs else {
            return
        }
        // TODO: - review wrapperType
        self.viewModels = discs
            .filter { $0.wrapperType == Constants.collection }
            .map { DetailViewModel(discography: $0) }
    }
    
    func initSubView() {
        Bundle.main.loadNibNamed("DetailView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
    }
    
    func configureTable() {
        let nib = UINib(nibName: DetailCell.cellReuseIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: DetailCell.cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension DetailView: UITableViewDelegate {}

extension DetailView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: DetailCell = self.tableView.dequeueReusableCell(withIdentifier: DetailCell.cellReuseIdentifier) as? DetailCell else {
            return UITableViewCell()
        }
        cell.setViewModel(viewModels[indexPath.row])
        return cell
    }
}
