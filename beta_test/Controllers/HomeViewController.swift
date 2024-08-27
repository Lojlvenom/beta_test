import UIKit

class HomeController: UIViewController {
    
    // MARK: - Variables
    private let viewModel: HomeViewModel
    
    private enum ViewType {
        case home
        case saved
    }
    
    private var currentViewType: ViewType = .home {
        didSet {
            switchView()
        }
    }
    
    // MARK: - UI Components
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .systemBackground
        tv.register(RepoCell.self, forCellReuseIdentifier: RepoCell.identifier)
        return tv
    }()
    
    private let segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Github Repos", "Saved"])
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    private let savedViewController: SavedViewController = {
        let svc = SavedViewController()
        svc.view.isHidden = true
        return svc
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
        
        self.segmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        self.navigationItem.title = "Swift Repos"
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(segmentedControl)
        self.view.addSubview(tableView)
        self.addChild(savedViewController)
        self.view.addSubview(savedViewController.view)
        savedViewController.didMove(toParent: self)
        
        self.segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.savedViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.segmentedControl.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.segmentedControl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.segmentedControl.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            self.tableView.topAnchor.constraint(equalTo: self.segmentedControl.bottomAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            self.savedViewController.view.topAnchor.constraint(equalTo: self.segmentedControl.bottomAnchor),
            self.savedViewController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.savedViewController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.savedViewController.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
        switchView()
    }
    
    // MARK: - Selectors
    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        self.currentViewType = sender.selectedSegmentIndex == 0 ? .home : .saved
    }
    
    private func switchView() {
        self.tableView.isHidden = self.currentViewType != .home
        self.savedViewController.view.isHidden = self.currentViewType != .saved
    }
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
