import SwiftUI
import MapKit

struct MapEditorView: View {
    @Environment(\.managedObjectContext) private var viewContext
    let place: Place
    @State private var latitude: String
    @State private var longitude: String
    @State private var zoom: Double

    init(place: Place) {
        self.place = place
        _latitude = State(initialValue: "\(place.latitude)")
        _longitude = State(initialValue: "\(place.longitude)")
        _zoom = State(initialValue: 10.0)
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Address")
                TextField("Address", text: .constant(place.name ?? ""))
                Image(systemName: "sparkle.magnifyingglass").foregroundColor(.blue)
                    .onTapGesture {
                        checkAddress()
                    }
            }
            HStack {
                Text("Lat/Long")
                TextField("Lat:", text: $latitude)
                TextField("Long:", text: $longitude)
                Image(systemName: "sparkle.magnifyingglass").foregroundColor(.blue)
                    .onTapGesture {
                        checkLocation()
                    }
            }
            Slider(value: $zoom, in: 10...60) {
                if !$0 {
                    checkZoom()
                }
            }
            ZStack {
                Map(coordinateRegion: .constant(region))
                VStack(alignment: .leading) {
                    Text("Latitude: \(latitude)").font(.footnote)
                    Text("Longitude: \(longitude)").font(.footnote)
                    Button("Update") {
                        checkMap()
                    }
                }.offset(x: 10, y: 280)
            }
        }
        .padding()
        .onAppear {
            latitude = "\(place.latitude)"
            longitude = "\(place.longitude)"
            zoom = 10.0
        }
    }
    
    private func checkAddress() {
        // Implement the address to location conversion logic
    }
    
    private func checkLocation() {
        // Implement the location to address conversion logic
    }
    
    private func checkZoom() {
        // Implement the zoom level adjustment logic
    }
    
    private func checkMap() {
        // Implement the map update logic
    }
    

    }
}
