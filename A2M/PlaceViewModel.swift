import Foundation
import CoreData
import SwiftUI

class PlaceViewModel: ObservableObject {
    let context = PersistentStorageController.shared.context
    



    func addPlace(name: String, location: String, notes: String, latitude: Double, longitude: Double, imageData: String) {
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
    
    func loadImage(for place: Place) -> Image {
        if let imageDataString = place.imageData,
           let imageURL = URL(string: imageDataString),
           let imageData = try? Data(contentsOf: imageURL),
           let uiImage = UIImage(data: imageData) {
            return Image(uiImage: uiImage)
        }

        return Image(systemName: "photo")
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
