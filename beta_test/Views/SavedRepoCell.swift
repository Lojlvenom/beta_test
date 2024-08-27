import Foundation

import UIKit

class SavedRepoCell: UITableViewCell {
    static let identifier = "SavedRepoCell"
    
    private(set) var savedRepo: SavedRepo!
    
    private let repoName: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "Error"
        return label
    }()
    
    private let starCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.text = "0 stars"
        return label
    }()
    
    public func configure(with savedRepo: SavedRepo) {
        self.savedRepo = savedRepo
        self.repoName.text = savedRepo.name
        self.starCountLabel.text = "Stars: \(savedRepo.starCount)"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        self.addSubview(repoName)
        self.addSubview(starCountLabel)
        repoName.translatesAutoresizingMaskIntoConstraints = false
        starCountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            repoName.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            repoName.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            starCountLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            starCountLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
