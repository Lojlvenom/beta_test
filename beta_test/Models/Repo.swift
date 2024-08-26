//
//  Repo.swift
//  beta_test
//
//  Created by Joao Camilo on 25/08/24.
//

import Foundation

struct RepoArray: Decodable {
    let items: [Repo]
}

struct Repo: Decodable {
    let id: Int
    let name: String
    let description: String
    let fullName: String
    
    // MARK: Implement coding keys to mantain code sanity
    let stargazersCount: Int
    
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case description = "description"
        case stargazersCount = "stargazers_count"
        case fullName = "full_name"
    }
    
}


extension Repo {
    public static func getMockRepos() -> [Repo]{
        return [
            Repo(id: 1, name: "foo bar", description: "foo bar repository", fullName: "foo", stargazersCount: 200),
            Repo(id: 1, name: "foo bar 2", description: "foo bar 2 repository", fullName: "foo", stargazersCount: 2),
            Repo(id: 1, name: "foo bar 3", description: "foo bar 3 repository", fullName: "foo", stargazersCount: 45)
        ]
    }
}


struct RepoPull: Codable {
    let id: Int
    let title: String
}
