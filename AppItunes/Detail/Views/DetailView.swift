//
//  DetailView.swift
//  AppItunes
//
//  Created by Nicolás López Cano on 5/1/22.
//

import UIKit

class DetailView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    private var viewModels: [DetailViewModel] = []
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
    
    func getDiscography(completion: @escaping ((([Artist]?) -> Void))) {
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

private extension DetailView {
    func commonInit() {
        initSubView()
        configureTable()
        createMockViewModels()
    }
    
    func createMockViewModels() {
        let mock1 = DetailViewModel(thumbnail: "https://is4-ssl.mzstatic.com/image/thumb/Music125/v4/db/d9/1a/dbd91afa-044d-637b-c557-847863c85a79/source/100x100bb.jpg", title: "Title", year: "2021")
        let mock2 = DetailViewModel(thumbnail: "https://is4-ssl.mzstatic.com/image/thumb/Music125/v4/db/d9/1a/dbd91afa-044d-637b-c557-847863c85a79/source/100x100bb.jpg", title: "Title2", year: "2022")
        viewModels.append(mock1)
        viewModels.append(mock2)
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
