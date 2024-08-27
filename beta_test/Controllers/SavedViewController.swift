import UIKit
import CoreData

class SavedViewController: UIViewController {
    
    // MARK: - Variables
    private let viewModel = SavedViewModel()
    
    // MARK: - UI Components
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .systemBackground
        tv.register(SavedRepoCell.self, forCellReuseIdentifier: SavedRepoCell.identifier)
        return tv
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.fetchSavedRepos()
        self.setupUI()

        self.viewModel.onSavedReposUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.viewModel.fetchSavedRepos()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        self.navigationItem.title = "Saved Repos"
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(tableView)
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
}

// MARK: - TableView Functions
extension SavedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.savedRepos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SavedRepoCell.identifier, for: indexPath) as? SavedRepoCell else {
            fatalError("Unable to dequeue SavedRepoCell in SavedViewController")
        }
        
        let savedRepo = self.viewModel.savedRepos[indexPath.row]
        cell.configure(with: savedRepo)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        // Handle row selection if needed, for example, navigate to a detail view
    }
}
