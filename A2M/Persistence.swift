import CoreData

class PersistentStorageController {
    static let shared = PersistentStorageController()

    let context: NSManagedObjectContext


    init() {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        self.context = container.viewContext
    }
}
