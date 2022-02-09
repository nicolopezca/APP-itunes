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
    private enum Constants {
        static let preSearchURL = "https://itunes.apple.com/search?term="
        static let postSearchURL = "&entity=allArtist&attribute=allArtistTerm"
        static let artistPreSearchURL = "https://itunes.apple.com/lookup?id="
        static let artistPostSearchURL = "&entity=album"
    }
    private var viewModels: [ArtistViewModel] = []
    weak var delegate: HomeViewDelegate?
    var id: Int?
    
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
    
    func getAuthorData(searchTerm: String, completion: @escaping ((([Artist]?) -> Void))) {
        let searchURL = Constants.preSearchURL + searchTerm + Constants.postSearchURL
        let urlSessionConfiguration = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: urlSessionConfiguration)
        guard let url = URL(string: searchURL) else {
            completion(nil)
            return
        }
        urlSession.dataTask(with: url) { data, response, error in
            self.handleItunesResponse(data: data, response: response, error: error, completion: completion)
        }.resume()
    }
    
    func getAuthorDisk(id: Int, completion: @escaping ((([Artist]?) -> Void))) {
        let searchURL = Constants.preSearchURL + String(id) + Constants.artistPostSearchURL
        let urlSessionConfiguration = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: urlSessionConfiguration)
        guard let url = URL(string: searchURL) else {
            completion(nil)
            return
        }
        urlSession.dataTask(with: url) { data, response, error in
            self.handleItunesResponse(data: data, response: response, error: error, completion: completion)
        }.resume()
    }
    
    func handleItunesResponse(data: Data?, response: URLResponse?, error: Error?, completion: @escaping ((([Artist]?) -> Void))) {
        guard let data =  getData(data: data, response: response) else {
            completion(nil)
            return
        }
        do {
            let itunesResponse = try JSONDecoder().decode(ItunesResponse.self, from: data)
            completion(itunesResponse.artists)
        } catch DecodingError.valueNotFound(let type, let context) {
            print("could not find type \(type) in JSON: \(context.debugDescription)")
        } catch let error as NSError {
            NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
        }
    }
    
    func obtainArtists(_ artists: [Artist]?) {
        guard let artists = artists else {
            return
        }
        // TODO: - review obtain ID
        //        artists.forEach { artist in
        //            if let artistId = artist.artistId {
        //                getDiscographyFromId(artistId)
        self.viewModels = artists.map { ArtistViewModel(artist: $0) }
        //            }
        //        }
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
    
    func getData(data: Data?, response: URLResponse?) -> Data? {
        guard let data = data,
              let response = response as? HTTPURLResponse,
              (200...299).contains(response.statusCode)
        else {
            return nil
        }
        return data
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
    
    func callWithUserText(searchedText: String) {
        let cleanSearch = searchedText.replacingOccurrences(of: " ", with: "+")
        getAuthorData(searchTerm: cleanSearch) { artists in
            self.obtainArtists(artists)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func getDiscographyFromId(_ id: Int) {
        getAuthorDisk(id: id) { artists in
            self.obtainArtistsDisc(artists)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension HomeView: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        callWithUserText(searchedText: searchText)
        searchBar.resignFirstResponder()
    }
}
