//
//  Repo.swift
//  beta_test
//
//  Created by Joao Camilo on 25/08/24.
//

import Foundation

struct Repo {
    let id: Int
    let name: String
    let description: String
    
    // MARK: Implement coding keys to mantain code sanity
    let stargazers_count: Int

    
}


extension Repo {
    public static func getMockRepos() -> [Repo]{
        return [
            Repo(id: 1, name: "foo bar", description: "foo bar repository", stargazers_count: 200),
            Repo(id: 1, name: "foo bar 2", description: "foo bar 2 repository", stargazers_count: 2),
            Repo(id: 1, name: "foo bar 3", description: "foo bar 3 repository", stargazers_count: 45)
        ]
    }
}
