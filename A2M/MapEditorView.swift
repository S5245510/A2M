import SwiftUI
import MapKit

struct MapEditorView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var viewModel: PlaceViewModel
    let place: Place
    
    @State private var coordinate: CLLocationCoordinate2D

    var body: some View {
        VStack {
            MapView(coordinate: coordinate)
                .onAppear {
                    coordinate = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
                }

            Button("Save Changes") {
                place.latitude = coordinate.latitude
                place.longitude = coordinate.longitude
                viewModel.savePlace(place: place)
            }
            .padding()
        }
    }
}
