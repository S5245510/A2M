//
//  CoreDataManager.swift
//  A2M
//
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    static let shared = CoreDataManager()
    let context: NSManagedObjectContext!
    
    private init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        context = appDelegate.persistentContainer.viewContext
    }
    
    // Add new place
    func addPlace(name: String, location: String, notes: String, imageData: Data) {
        let newPlace = Place(context: context)
        newPlace.name = name
        newPlace.location = location
        newPlace.notes = notes
        newPlace.imageData = imageData
        saveContext()
    }
    
    // Fetch all places
    func fetchAllPlaces() -> [Place]? {
        do {
            let places = try context.fetch(Place.fetchRequest())
            return places as? [Place]
        } catch {
            print("Failed to fetch places: \(error)")
            return nil
        }
    }
    
    // Delete place
    func deletePlace(place: Place) {
        context.delete(place)
        saveContext()
    }
    
    // Save context
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("An error occurred while saving: \(error)")
            }
        }
    }
}
