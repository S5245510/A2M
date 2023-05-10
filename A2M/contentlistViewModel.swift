import Foundation
import CoreData

class ChecklistViewModel: ObservableObject {
    @Published var isAdding = false
    @Published var name = ""
    @Published var location = ""
    @Published var notes = ""
    @Published var places: [Place] = []
    var title = "My Places"
    
    private let context = Persistence.shared.context
    
    init() {
        fetchPlaces()
    }
    
    func fetchPlaces() {
        do {
            places = try context.fetch(Place.fetchRequest())
        } catch {
            print("Error fetching places: \(error.localizedDescription)")
        }
    }
    
    func addPlace() {
        let newPlace = Place(context: context)
        newPlace.name = name
        newPlace.location = location
        newPlace.notes = notes
        newPlace.imageData = UIImage(named: "default-image")?.jpegData(compressionQuality: 1.0)
        Persistence.shared.saveContext()
        name = ""
        location = ""
        notes = ""
        isAdding = false
        fetchPlaces()
    }
    
    func deletePlace(offsets: IndexSet) {
        offsets.forEach { index in
            let place = places[index]
            context.delete(place)
        }
        Persistence.shared.saveContext()
        fetchPlaces()
    }
}
