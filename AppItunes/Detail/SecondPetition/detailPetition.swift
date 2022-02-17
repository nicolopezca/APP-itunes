//
//  detailPetition.swift
//  AppItunes
//
//  Created by Nicolás López Cano on 10/2/22.
//

import Foundation

class DetailPetition {
    
    private enum Constants {
        static let preSearchURL = "https://itunes.apple.com/lookup?id="
        static let postSearchURL = "&entity=album"
        static let collection = "collection"
    }
    
    func getDiscography(id: Int, completion: @escaping ((([Disc]?) -> Void))) {
        let urlSessionConfiguration = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: urlSessionConfiguration)
        let searchURL = Constants.preSearchURL + String(id) + Constants.postSearchURL
        guard let url = URL(string: searchURL) else {
            completion(nil)
            return
        }
        urlSession.dataTask(with: url) { data, response, error in
            self.handleDetailResponse(data: data, response: response, error: error, completion: completion)
        }.resume()
    }
    
    func handleDetailResponse(data: Data?,
                              response: URLResponse?,
                              error: Error?,
                              completion: @escaping ((([Disc]?) -> Void))) {
        guard let data = getData(data: data, response: response) else {
            completion(nil)
            return
        }
        do {
            let detailResponse = try getDecoder().decode(DiscResponse.self, from: data)
            completion(detailResponse.discs)
        } catch DecodingError.valueNotFound(let type, let context) {
            print("could not find type \(type) in JSON: \(context.debugDescription)")
        } catch let error as NSError {
            NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
        }
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
    
    func getDecoder() -> JSONDecoder {
        let formatter = DateFormatter()
        formatter.dateFormat = TimeFormat.yyyyMMddTHHmmssZ.rawValue
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        return decoder
    }
    
}
