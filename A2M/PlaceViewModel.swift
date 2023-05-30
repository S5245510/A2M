import Foundation
import CoreData
import SwiftUI

class PlaceViewModel: ObservableObject {
    let context = PersistentStorageController.shared.context
    
    func loadDefaultPlaces() {
        let defaultPlaces = [["Place 1", "Location 1", "Note 1", 0.0, 0.0],
                             ["Place 2", "Location 2", "Note 2", 0.0, 0.0],
                             ["Place 3", "Location 3", "Note 3", 0.0, 0.0]]
        
        defaultPlaces.forEach {
            let newPlace = Place(context: context)
            newPlace.name = $0[0] as? String
            newPlace.location = $0[1] as? String
            newPlace.notes = $0[2] as? String
            newPlace.latitude = $0[3] as? Double ?? 0.0
            newPlace.longitude = $0[4] as? Double ?? 0.0
            // Add your default imageData here
            
            saveContext()
        }
    }


    func addPlace(name: String, location: String, notes: String, latitude: Double, longitude: Double, imageData: Data) {
        let newPlace = Place(context: context)
        newPlace.name = name
        newPlace.location = location
        newPlace.notes = notes
        newPlace.latitude = latitude
        newPlace.longitude = longitude
        newPlace.imageData = imageData

        saveContext()
    }

    func savePlace(place: Place) {
        saveContext()
    }

    func deletePlace(place: Place) {
        context.delete(place)
        saveContext()
    }

    private func saveContext() {
        do {
            try context.save()
        } catch {
            let error = error as NSError
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    }
}
