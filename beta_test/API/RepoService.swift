//
//  RepoService.swift
//  beta_test
//
//  Created by Joao Camilo on 25/08/24.
//

import Foundation

enum RepoServiceError: Error {
    case unknown(String = "A unknown error has happend")
    case decodingError(String = "Error decoding server response")
    
}


class RepoService {
    static func fetchRepos(with endpoint: Endpoint, completion: @escaping (Result<[Repo], RepoServiceError>) -> Void) {
        
        guard let request = endpoint.request else { return }
        print("isnide request")
        print(request)
        URLSession.shared.dataTask(with: request) { data, resp, error in
            
            if let error  = error {
                print("erro")
                completion(.failure(.unknown(error.localizedDescription)))
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let repoData = try decoder.decode(RepoArray.self, from: data)
                    completion(.success(repoData.items))
                } catch let err {
                    completion(.failure(.decodingError()))
                }
            
            } else {
                print(completion(.failure(.unknown())))
            }
        }.resume()
        
    }
}
