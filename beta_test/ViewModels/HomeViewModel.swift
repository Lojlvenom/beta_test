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
        print("initializing...")
        self.fetchRepos()
    }
    
    public func fetchRepos() {
        print("inside repos")
        let endpoint = Endpoint.fetchRepos()
        print("inside repos 2")
        RepoService.fetchRepos(with: endpoint, completion: {  [weak self] result in
            switch result {
            case .success(let repos):
                print(repos)
                self?.repos = repos
                
            case .failure(let error):
                print("repo erros \(error)")
                self?.onError?(error)
            }
        })
    }
}
