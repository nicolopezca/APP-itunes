//
//  HomeViewController.swift
//  AppItunes
//
//  Created by Nicolás López Cano on 14/12/21.
//

import UIKit

class HomeView: UIView, UITableViewDelegate, UITableViewDataSource {
    private var viewModels: [ArtistViewModel] = []
    weak var delegate: MyDelegate?
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.cellTapped()

    }
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: AuthorCell = self.tableView.dequeueReusableCell(withIdentifier: AuthorCell.cellReuseIdentifier) as? AuthorCell else {
            return UITableViewCell()
        }
        cell.setViewModel(viewModels[indexPath.row])
        return cell
    }
}

protocol MyDelegate: class {
    func cellTapped()
}

private extension HomeView {
    func commonInit() {
        initSubView()
        configureTable()
        getAuthorData { artists in
            self.obtainArtists(artists)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func initSubView() {
        Bundle.main.loadNibNamed("HomeView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
    }
    
    func getAuthorData(completion: @escaping ((([Artist]?) -> Void))) {
        let urlSessionConfiguration = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: urlSessionConfiguration)
        guard let url = URL(string: "https://itunes.apple.com/search?term=avicii&entity=allArtist&attribute=allArtistTerm") else {
            completion(nil)
            return
        }
        urlSession.dataTask(with: url) { data, response, error in
            self.handleItunesResponse(data: data, response: response, error: error, completion: completion)
        }.resume()
    }
    
    func handleItunesResponse(data: Data?, response: URLResponse?, error: Error?, completion: @escaping ((([Artist]?) -> Void))) {
        guard let data = data,
              let response = response as? HTTPURLResponse,
              (200...299).contains(response.statusCode)
        else {
            completion(nil)
            return
        }
        do {
            let itunesResponse = try JSONDecoder().decode(ItunesReponse.self, from: data)
            completion(itunesResponse.artists)
            print(itunesResponse.artists)
        } catch DecodingError.keyNotFound(let key, let context) {
            print("could not find key \(key) in JSON: \(context.debugDescription)")
            
        } catch DecodingError.valueNotFound(let type, let context) {
            print("could not find type \(type) in JSON: \(context.debugDescription)")
            
        } catch DecodingError.typeMismatch(let type, let context) {
            print("type mismatch for type \(type) in JSON: \(context.debugDescription)")
            
        } catch DecodingError.dataCorrupted(let context) {
            print("data found to be corrupted in JSON: \(context.debugDescription)")
            
        } catch let error as NSError {NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")}
    }
    
        func obtainArtists(_ artists: [Artist]?) {
            guard let artists = artists else {
                return
            }
            artists.forEach { artist in
                if let artistName = artist.artistName,
                   let primaryGenreName = artist.primaryGenreName {
//                   let discography = artist.collectionName {
                    self.viewModels.append(ArtistViewModel(author: artistName, style: primaryGenreName))
//                    self.viewModels.append(ArtistViewModel(author: artistName, style: primaryGenreName, discography: discography))
                }
            }
        }
        
        func configureTable() {
            let nib = UINib(nibName: AuthorCell.cellReuseIdentifier, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: AuthorCell.cellReuseIdentifier)
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
