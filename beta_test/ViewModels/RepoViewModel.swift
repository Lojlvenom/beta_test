//
//  ViewCryptoControllerViewModel.swift
//  iCryypt-Pro
//
//  Created by YouTube on 2023-04-01.
//

import Foundation
import UIKit

class RepoViewModel {
    
    let repo: Repo
    
    init(_ repo: Repo) {
        self.repo = repo
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
