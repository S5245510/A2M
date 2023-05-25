import CoreData

class PersistentStorageController {
    static let shared = PersistentStorageController()

    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "A2M")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}
