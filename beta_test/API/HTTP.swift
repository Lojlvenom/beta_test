//
//  HTTP.swift
//  beta_test
//
//  Created by Joao Camilo on 25/08/24.
//

import Foundation

enum HTTP {
    
    enum Method: String {
        case get = "GET"
    }
    
    enum Headers {
        
        enum Key: String {
            case contentType = "Content-Type"
        }
        
        enum Value: String {
            case applicationJson = "application/json"
        }
    }
}
