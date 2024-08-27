import UIKit

class ViewRepoController: UIViewController {
    
    // MARK: - Variables
    let viewModel: RepoViewModel
    
    // MARK: - UI Components
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        return sv
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.text = "Error"
        return label
    }()
    
    private let starCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.text = "Error"
        return label
    }()
    
    private let pullsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.text = "Error"
        return label
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.addTarget(self, action: #selector(toggleSave), for: .touchUpInside)
        return button
    }()
    
    private lazy var vStack: UIStackView = {
        let vStack = UIStackView(arrangedSubviews: [descriptionLabel, starCountLabel, pullsLabel, saveButton])
        vStack.axis = .vertical
        vStack.spacing = 12
        vStack.distribution = .fill
        vStack.alignment = .center
        return vStack
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - LifeCycle
    init(_ viewModel: RepoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        self.view.backgroundColor = .systemBackground
        self.navigationItem.title = self.viewModel.repo.name
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: nil, action: nil)
        
        self.descriptionLabel.text = self.viewModel.desciptionLabel
        self.starCountLabel.text = "Repo stars: \(self.viewModel.starCountLabel)"
        self.pullsLabel.text = "Loading Pull Requests...."
        
        self.tableView.dataSource = self
        self.tableView.delegate = self

        self.viewModel.onPullsUpdate = {
            DispatchQueue.main.async {
                if self.viewModel.pullRequests.count == 0 {
                    self.pullsLabel.text = "No Pull requests"
                } else {
                    self.pullsLabel.text = "Open Pull requests"
                }
                
                self.tableView.reloadData()
            }
        }
        
        self.viewModel.onSaveStateChanged = {
            DispatchQueue.main.async {
                self.updateSaveButtonTitle()
            }
        }
        
        updateSaveButtonTitle()
    }

    // MARK: - UI Setup
    private func setupUI() {
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        self.contentView.addSubview(vStack)
        self.contentView.addSubview(tableView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        vStack.translatesAutoresizingMaskIntoConstraints = false
        
        let height = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        height.priority = UILayoutPriority(rawValue: 250)
        height.isActive = true
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            vStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            vStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            vStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: vStack.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 400)
        ])
    }
    
    @objc private func toggleSave() {
        if viewModel.isRepoSaved() {
            viewModel.removeFromCoreData()
        } else {
            viewModel.saveToCoreData()
        }
    }
    
    private func updateSaveButtonTitle() {
        if viewModel.isRepoSaved() {
            saveButton.setTitle("Remove", for: .normal)
        } else {
            saveButton.setTitle("Save", for: .normal)
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension ViewRepoController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pullRequests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.pullRequests[indexPath.row].title
        return cell
    }
}
