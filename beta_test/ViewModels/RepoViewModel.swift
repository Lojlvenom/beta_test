//
//  ViewCryptoControllerViewModel.swift
//  iCryypt-Pro
//
//  Created by YouTube on 2023-04-01.
//

import Foundation
import UIKit

class RepoViewModel {
    var onPullsUpdate: (() -> Void)?
    
    private(set) var pullRequests: [RepoPull] = [] {
        didSet {
            self.onPullsUpdate?()
        }
    }
    
    
    public func fetchPullRequests(pullUrl: String) {
        let endpoint = Endpoint.fetchPullRequests(url: "/repos/\(pullUrl)/pulls")
        RepoService.fetchPullRequests(with: endpoint, completion: {  [weak self] result in
            switch result {
            case .success(let pullRequests):
                
                print("pull data :",pullRequests)
                self?.pullRequests = pullRequests
                
            case .failure(let error):
//                TODO implement error handling
                print("repo erros \(error)")
            }
        })
    }

    
    let repo: Repo
    
    init(_ repo: Repo) {
        self.repo = repo
        self.fetchPullRequests(pullUrl: repo.fullName )
    }
    
    var nameLabel: String {
        return self.repo.name
    }
    
    // MARK: - Computed Properties
    var desciptionLabel: String {
        return self.repo.description
    }
    
    
    var starCountLabel: Int {
        return self.repo.stargazersCount
    }
    
    
}
