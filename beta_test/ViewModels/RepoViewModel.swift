import Foundation
import UIKit
import CoreData

class RepoViewModel {
    var onPullsUpdate: (() -> Void)?
    var onSaveStateChanged: (() -> Void)?
    
    private(set) var pullRequests: [RepoPull] = [] {
        didSet {
            self.onPullsUpdate?()
        }
    }
    
    let repo: Repo
    
    init(_ repo: Repo) {
        self.repo = repo
        self.fetchPullRequests(pullUrl: repo.fullName)
    }
    
    public func fetchPullRequests(pullUrl: String) {
        let endpoint = Endpoint.fetchPullRequests(url: "/repos/\(pullUrl)/pulls")
        RepoService.fetchPullRequests(with: endpoint, completion: { [weak self] result in
            switch result {
            case .success(let pullRequests):
                self?.pullRequests = pullRequests
            case .failure(let error):
                // TODO: Implement error handling
                print("repo errors \(error)")
            }
        })
    }
    
    // MARK: - Core Data Operations
    func saveToCoreData() {
        let context = getContext()
        
        let fetchRequest: NSFetchRequest<SavedRepo> = SavedRepo.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", self.repo.name)
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.isEmpty {
                // The repo is not saved, so we need to save it
                let savedRepo = SavedRepo(context: context)
                savedRepo.name = self.repo.name
                savedRepo.desc = self.repo.description
                savedRepo.starCount = Int64(self.repo.stargazersCount)
                
                try context.save()
                self.onSaveStateChanged?()
            }
        } catch let error as NSError {
            // TODO: Implement error handling
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func removeFromCoreData() {
        let context = getContext()
        
        let fetchRequest: NSFetchRequest<SavedRepo> = SavedRepo.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", self.repo.name)
        
        do {
            let results = try context.fetch(fetchRequest)
            for object in results {
                context.delete(object)
            }
            try context.save()
            self.onSaveStateChanged?()
        } catch let error as NSError {
            // TODO: Implement error handling
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func isRepoSaved() -> Bool {
        let context = getContext()
        
        let fetchRequest: NSFetchRequest<SavedRepo> = SavedRepo.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", self.repo.name)
        
        do {
            let results = try context.fetch(fetchRequest)
            return !results.isEmpty
        } catch {
            return false
        }
    }
    
    private func getContext() -> NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    // MARK: - Computed Properties
    var nameLabel: String {
        return self.repo.name
    }
    
    var desciptionLabel: String {
        return self.repo.description
    }
    
    var starCountLabel: Int {
        return self.repo.stargazersCount
    }
}
