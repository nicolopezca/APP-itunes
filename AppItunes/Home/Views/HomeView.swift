//
//  HomeViewController.swift
//  AppItunes
//
//  Created by Nicolás López Cano on 14/12/21.
//

import UIKit

protocol HomeViewDelegate: AnyObject {
    func cellTapped(artist: Artist)
}

class HomeView: UIView {
    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    private var viewModels: [ArtistViewModel] = []
    weak var delegate: HomeViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
}

private extension HomeView {
    func commonInit() {
        initSubView()
        configureTable()
        configureSearchBar()
    }
    
    func initSubView() {
        Bundle.main.loadNibNamed("HomeView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
    }
    
    func fillViewModel(_ artists: [Artist]?) {
        guard let artists = artists else {
            return
        }
        self.viewModels = artists.map { ArtistViewModel(artist: $0) }
    }
    
    func obtainArtistsDisc(_ artists: [Artist]?) {
        guard let artists = artists else {
            return
        }
    }
    
    func configureTable() {
        let nib = UINib(nibName: AuthorCell.cellReuseIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: AuthorCell.cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func configureSearchBar() {
        searchBar.delegate = self
    }
}

extension HomeView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.cellTapped(artist: viewModels[(indexPath).row].artist)
        self.searchBar.searchTextField.endEditing(true)
    }
}

extension HomeView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: AuthorCell = self.tableView.dequeueReusableCell(withIdentifier: AuthorCell.cellReuseIdentifier) as? AuthorCell else {
            return UITableViewCell()
        }
        cell.setViewModel(viewModels[indexPath.row])
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func makeFirstCall(searchedText: String) {
        let cleanSearch = searchedText.replacingOccurrences(of: " ", with: "+")
        let request = ArtistCall(search: cleanSearch)
        request.getAuthorData { artists in
            self.fillViewModel(artists)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension HomeView: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        makeFirstCall(searchedText: searchText)
        searchBar.resignFirstResponder()
    }
}
