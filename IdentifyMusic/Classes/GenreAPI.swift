//
//  GenreAPI.swift
//  IdentifyMusic
//
//  Created by Khaled Abo hassob on 3/5/2024.
//

import Foundation
import Alamofire

class GenreAPI {
    static func fetchGenres(completion: @escaping (Result<GenreResponse, Error>) -> Void) {
        // Define the URL for fetching genres from the Apple Music API
        guard let url = URL(string: "https://api.music.apple.com/v1/catalog/eg/genres") else {
            completion(.failure(NSError(domain: "InvalidURL", code: 0, userInfo: nil)))
            return
        }
        let token = UserDefaultsManager.shared().token
        AF.request(url,headers: [ "Authorization" : "Bearer \(token ?? "")"]).responseDecodable { (respone: AFDataResponse<GenreResponse>) in
            switch respone.result {
                
                
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
            
            
        }
        
        
        
        
    }
    
    static func fetchGenresSongs(id: String, completion: @escaping (Result<GenreResponse, Error>) -> Void) {
        // Define the URL for fetching genres from the Apple Music API
        guard let url = URL(string: "https://api.music.apple.com/v1/catalog/us/songs?genre=\(id)") else {
            completion(.failure(NSError(domain: "InvalidURL", code: 0, userInfo: nil)))
            return
        }
        let token = UserDefaultsManager.shared().token
        AF.request(url,headers: [ "Authorization" : "Bearer \(token ?? "")"]).responseDecodable { (respone: AFDataResponse<GenreResponse>) in
            switch respone.result {
                
                
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
            
            
        }
        
        
        
        
    }
    
}
