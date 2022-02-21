//
//  APICalls.swift
//  AppItunes
//
//  Created by Nicolás López Cano on 17/2/22.
//

import Foundation

private enum Constants {
    static let preSearchURL = "https://itunes.apple.com/search?term="
    static let postSearchURL = "&entity=allArtist&attribute=allArtistTerm"
}
    
class ArtistCall {
    let url: String
    init(search: String) {
        self.url = Constants.preSearchURL + search + Constants.postSearchURL
    }
    func getAuthorData(completion: @escaping ((([Artist]?) -> Void))) {
        let urlSessionConfiguration = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: urlSessionConfiguration)
        guard let url = URL(string: url) else {
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
