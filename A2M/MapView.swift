import SwiftUI
import MapKit

struct MapView: View {
    @State var coordinate: CLLocationCoordinate2D

    var body: some View {
        Map(coordinateRegion: coordinateRegion)
    }

    private var coordinateRegion: Binding<MKCoordinateRegion> {
        Binding(
            get: {
                MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
            },
            set: {
                coordinate = $0.center
            }
        )
    }
}
