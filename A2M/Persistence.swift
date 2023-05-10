import Foundation
import CoreData

struct Persistence {
    static var shared = Persistence()
    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "FavouritePlaces")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Error loading data, \(error)")
            }
        }
    }

    func save() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
