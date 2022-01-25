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
    private var artistId: Int?
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
        artistId = id
        getDiscography { discs in
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
    
    func handleDetailResponse(data: Data?, response: URLResponse?, error: Error?, completion: @escaping ((([Discography]?) -> Void))) {
        guard let data = checkData(data: data, response: response) else {
            completion(nil)
            return
        }
        do {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(formatter)
            let detailResponse = try decoder.decode(DiscResponse.self, from: data)
            completion(detailResponse.discs)
            
        } catch DecodingError.valueNotFound(let type, let context) {
            print("could not find type \(type) in JSON: \(context.debugDescription)")
        } catch let error as NSError {
            NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
        }
    }
    
    func getDiscography(completion: @escaping ((([Discography]?) -> Void))) {
        let urlSessionConfiguration = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: urlSessionConfiguration)
        if let id = artistId {
            guard let url = URL(string: "https://itunes.apple.com/lookup?id=\(id)&entity=album") else {
                completion(nil)
                return
            }
            urlSession.dataTask(with: url) { data, response, error in
                self.handleDetailResponse(data: data, response: response, error: error, completion: completion)
            }.resume()
        }
        return
    }
    
    func obtainDetailData(_ discs: [Discography]?) {
        guard let discs = discs else {
            return
        }
        // TODO: - review wrapperType
        discs.forEach { discs in
            if discs.wrapperType == "collection" {
                self.viewModels.append(DetailViewModel(discographies: discs))
            }
        }
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
    
    func checkData(data: Data?, response: URLResponse?) -> Data? {
        guard let data = data,
              let response = response as? HTTPURLResponse,
              (200...299).contains(response.statusCode)
        else {
            return nil
        }
        return data
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
