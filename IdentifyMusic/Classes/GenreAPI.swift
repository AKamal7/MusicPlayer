//
//  GenreAPI.swift
//  IdentifyMusic
//
//  Created by Khaled Abo hassob on 3/5/2024.
//

import Foundation

class GenreAPI {
    static func fetchGenres(completion: @escaping (Result<[Genre], Error>) -> Void) {
        // Define the URL for fetching genres from the Apple Music API
        guard let url = URL(string: "https://api.music.apple.com/v1/catalog/eg/genres") else {
            completion(.failure(NSError(domain: "InvalidURL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Set your authorization token here
        let token = UserDefaultsManager.shared().token
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Handle response...
        }
        
        task.resume()
    }
}
