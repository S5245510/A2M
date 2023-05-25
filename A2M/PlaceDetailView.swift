import MapKit
import Foundation
import SwiftUI


struct PlaceDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    let place: Place
    @State private var coordinate: CLLocationCoordinate2D

    var body: some View {
        VStack {
            MapView(coordinate: $coordinate)
            Text(place.name ?? "")
            Text(place.location ?? "")
            Text(place.notes ?? "")
            // Edit button to modify the details
            Button("Update Location") {
                place.latitude = coordinate.latitude
                place.longitude = coordinate.longitude
                CoreDataManager.shared.saveContext()
            }
        }
        .navigationBarItems(trailing: Button("Edit") {
            // Implement the edit functionality
        })
        .onAppear {
            coordinate = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
        }
    }
}
