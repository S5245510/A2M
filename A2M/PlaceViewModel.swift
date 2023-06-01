import Foundation
import CoreData
import SwiftUI

class PlaceViewModel: ObservableObject {
    let context = PersistentStorageController.shared.context
    
    func loadDefaultData() {
        let defaultPlaces: [[Any]] = [
            ["Hong Kong", "", "Notes A", 22.3, 114.17, ""],
            ["Sydney", "", "Notes B", -33.9, 151.2086, "https://wakeup.com.au/wp-content/themes/yootheme/cache/3shutterstock_1094901527-2fa9cd47.jpeg"],
            ["Brisbane", "", "Notes C", -27, 153, ""]
        ]
        
        defaultPlaces.forEach { placeData in
            let newPlace = Place(context: context)
            newPlace.name = placeData[0] as? String ?? ""
            newPlace.location = placeData[1] as? String ?? ""
            newPlace.notes = placeData[2] as? String ?? ""
            newPlace.latitude = placeData[3] as? Double ?? 0.0
            newPlace.longitude = placeData[4] as? Double ?? 0.0
            newPlace.imageData = placeData[5] as? String ?? ""
        }
        
        saveContext()
    }
    
    
    
    
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
