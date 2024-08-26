//
//  HomeViewModel.swift
//  beta_test
//
//  Created by Joao Camilo on 25/08/24.
//

import Foundation

class HomeViewModel {
    
    var onRepoUpdated: (() -> Void)?
    var onError: ((RepoServiceError) -> Void)?
    
    private(set) var repos: [Repo] = [] {
        didSet {
            self.onRepoUpdated?()
        }
    }
    
    init() {
        self.fetchRepos()
    }
    
    public func fetchRepos() {
        let endpoint = Endpoint.fetchRepos()
        RepoService.fetchRepos(with: endpoint, completion: {  [weak self] result in
            switch result {
            case .success(let repos):
                self?.repos = repos
            case .failure(let error):
                self?.onError?(error)
            }
        })
    }
}
