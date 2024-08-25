//
//  ViewCryptoController.swift
//  iCryypt-Pro
//
//  Created by YouTube on 2023-03-31.
//

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
    

    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.text = "Error"
        return label
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
    
    
    private lazy var vStack: UIStackView = {
       let vStack = UIStackView(arrangedSubviews: [nameLabel, descriptionLabel, starCountLabel,])
        vStack.axis = .vertical
        vStack.spacing = 12
        vStack.distribution = .fill
        vStack.alignment = .center
        return vStack
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
        
        self.nameLabel.text = self.viewModel.nameLabel
        self.descriptionLabel.text = self.viewModel.desciptionLabel
        self.starCountLabel.text = "\(self.viewModel.starCountLabel)"
        
        
    }
    
    
    // MARK: - UI Setup
    private func setupUI() {
           self.view.addSubview(scrollView)
           self.scrollView.addSubview(contentView)
           self.contentView.addSubview(vStack)
           
           scrollView.translatesAutoresizingMaskIntoConstraints = false
           contentView.translatesAutoresizingMaskIntoConstraints = false
           vStack.translatesAutoresizingMaskIntoConstraints = false
           
           let height = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
           height.priority = UILayoutPriority(1)
           height.isActive = true
           
           NSLayoutConstraint.activate([
               scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
               scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
               scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
               scrollView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor),
               scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
           
               contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
               contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
               contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
               contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
               contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
               
               
               vStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
               vStack.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
               vStack.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
               vStack.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
           ])
       }

}
