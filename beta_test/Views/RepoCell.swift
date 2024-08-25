//
//  RepoCell.swift
//  beta_test
//
//  Created by Joao Camilo on 25/08/24.
//

import Foundation
import UIKit

class RepoCell: UITableViewCell {
    static let identifier = "RepoCell"
    
    private(set) var repo: Repo!
    
    
    private let repoName: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "Error"
        return label
    }()
    
    public func configure(with repo: Repo) {
        self.repo = repo
        self.repoName.text = repo.name
    }
    override init(style:UITableViewCell.CellStyle, reuseIdentifier: String? ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - UI Setup
    private func setupUI() {
        self.addSubview(repoName)
        repoName.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            repoName.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            repoName.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
