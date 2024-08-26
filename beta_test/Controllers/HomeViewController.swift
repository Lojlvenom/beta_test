//
//  HomeController.swift
//  iCryypt-Pro
//
//  Created by YouTube on 2023-03-31.
//

import UIKit

class HomeController: UIViewController {
    
    // MARK: - Variables
    private let viewModel: HomeViewModel
    
    
    // MARK: - UI Components
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .systemBackground
        tv.register(RepoCell.self, forCellReuseIdentifier: RepoCell.identifier)
        return tv
    }()
    
    init(_ viewModel: HomeViewModel = HomeViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.viewModel.onRepoUpdated = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    
    // MARK: - UI Setup
    private func setupUI() {
        self.navigationItem.title = "Swift Repos"
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
    
    
    // MARK: - Selectors
    
}

// MARK: - TableView Functions
extension HomeController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepoCell.identifier, for: indexPath) as? RepoCell else {
            fatalError("Unable to dequeue CoinCell in HomeController")
        }
        
        let repo = self.viewModel.repos[indexPath.row]
        cell.configure(with: repo)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        let repo = self.viewModel.repos[indexPath.row]
        let vm = RepoViewModel(repo)
        let vc = ViewRepoController(vm)
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
}
