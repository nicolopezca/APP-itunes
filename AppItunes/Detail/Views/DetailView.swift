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
    
    func getDiscography(completion: @escaping ((([Discography]?) -> Void))) {
        let urlSessionConfiguration = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: urlSessionConfiguration)
        guard let url = URL(string: "https://itunes.apple.com/lookup?id=298496035&entity=album") else {
            completion(nil)
            return
        }
        urlSession.dataTask(with: url) { data, response, error in
            self.handleDetailResponse(data: data, response: response, error: error, completion: completion)
        }.resume()
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
        getDiscography { discs in
            self.obtainDetailData(discs)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func handleDetailResponse(data: Data?, response: URLResponse?, error: Error?, completion: @escaping ((([Discography]?) -> Void))) {
        guard let data = data,
              let response = response as? HTTPURLResponse,
              (200...299).contains(response.statusCode)
        else {
            completion(nil)
            return
        }
        do {
            let detailResponse = try JSONDecoder().decode(DiscResponse.self, from: data)
            completion(detailResponse.discs)
            print(detailResponse.discs)
        } catch DecodingError.valueNotFound(let type, let context) {
            print("could not find type \(type) in JSON: \(context.debugDescription)")
        } catch DecodingError.typeMismatch(let type, let context) {
            print("type mismatch for type \(type) in JSON: \(context.debugDescription)")
        } catch let error as NSError {
            NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
        }
    }
    
    func obtainDetailData(_ discs: [Discography]?) {
        guard let discs = discs else {
            return
        }
        discs.forEach { discs in
            if let title = discs.collectionName,
               let thumbnail = discs.artworkUrl100,
               let year = discs.releaseDate {
                self.viewModels.append(DetailViewModel(thumbnail: thumbnail, title: title, year: year))
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
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
