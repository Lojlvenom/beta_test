import Foundation
import CoreData
import UIKit

class SavedViewModel {
    
    var onSavedReposUpdated: (() -> Void)?
    
    private(set) var savedRepos: [SavedRepo] = [] {
        didSet {
            self.onSavedReposUpdated?()
        }
    }
    
    init() {
        fetchSavedRepos()
    }
    
    // MARK: - Fetch Data from Core Data
    func fetchSavedRepos() {
        let fetchRequest: NSFetchRequest<SavedRepo> = SavedRepo.fetchRequest()
        
        do {
            let context = getContext()
            self.savedRepos = try context.fetch(fetchRequest)
        } catch let error as NSError {
            // TODO: Implement error handling
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    // MARK: - Save Repo
    func saveRepo(_ repo: Repo) {
        let context = getContext()
        
        let savedRepo = SavedRepo(context: context)
        savedRepo.name = repo.name
        savedRepo.desc = repo.description
        savedRepo.starCount = Int64(repo.stargazersCount)
        
        do {
            try context.save()
            fetchSavedRepos()
        } catch let error as NSError {
            // TODO: Implement error handling
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    // MARK: - Remove Repo
    func removeRepo(_ repo: Repo) {
        let context = getContext()
        
        let fetchRequest: NSFetchRequest<SavedRepo> = SavedRepo.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", repo.name)
        
        do {
            let results = try context.fetch(fetchRequest)
            for object in results {
                context.delete(object)
            }
            try context.save()
            fetchSavedRepos()
        } catch let error as NSError {
            // TODO: Implement error handling
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    private func getContext() -> NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    func isRepoSaved(_ repo: Repo) -> Bool {
        return savedRepos.contains { $0.name == repo.name }
    }
}
