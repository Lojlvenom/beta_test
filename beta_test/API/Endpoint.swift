//
//  Endpoint.swift
//  beta_test
//
//  Created by Joao Camilo on 25/08/24.
//

import Foundation

enum Endpoint {
    
    case fetchRepos(url: String = "/search/repositories")
    
    var request: URLRequest? {
        guard let url = self.url else {
            print("Can't mount URL")
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = self.httpMethod
        request.httpBody = self.httpBody
        return request
    }
    
    private var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.github.com"
        components.path = "/search/repositories"
        components.queryItems = [
            URLQueryItem(name: "q", value: "language:Swift"),
            URLQueryItem(name: "sort", value: "stars")
        ]
        
        return components.url
    }
    
    private var path: String {
        switch self {
        case .fetchRepos(let url):
            return url
        }
    }
    
    private var httpMethod: String {
        switch self {
        case .fetchRepos:
            return HTTP.Method.get.rawValue
        }
    }
    
    private var httpBody: Data? {
        switch self {
        case .fetchRepos:
            return nil
        }
    }
}

