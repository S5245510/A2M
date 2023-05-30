import SwiftUI
import MapKit

struct MapEditorView: View {
    @ObservedObject var model: MyLocation
    @Binding var place: Place
    @ObservedObject var viewModel: PlaceViewModel
    @State private var latitude: String
    @State private var longitude: String
    @State private var zoom: Double
    
    init(model: MyLocation, place: Binding<Place>, viewModel: PlaceViewModel) {
        self.model = model
        self._place = place
        self.viewModel = viewModel
        self._latitude = State(initialValue: "\(place.wrappedValue.latitude)")
        self._longitude = State(initialValue: "\(place.wrappedValue.longitude)")
        self._zoom = State(initialValue: 10.0)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 10) {
                HStack{
                    TextField("Address", text: Binding(
                    get: { place.name ?? "" },
                    set: { place.name = $0 }
                    ))
                    Image(systemName: "sparkle.magnifyingglass")
                        .foregroundColor(.blue)
                        .onTapGesture {
                            checkAddress()
                        }
                    
                }
                
                HStack {
                    Text("Lat/Long")
                    TextField("Lat:", text: $latitude)
                    TextField("Long:", text: $longitude)
                    Image(systemName: "sparkle.magnifyingglass")
                        .foregroundColor(.blue)
                        .onTapGesture {
                            checkLocation()
                        }
                }
                
                Slider(value: $zoom, in: 10...60) { changed in
                    if !changed {
                        checkZoom()
                    }
                }
                
                ZStack {
                    Map(coordinateRegion: $model.region)
                    VStack(alignment: .leading) {
                        Text("Latitude: \(model.region.center.latitude)").font(.footnote)
                        Text("Longitude: \(model.region.center.longitude)").font(.footnote)
                        Button("Update") {
                            checkMap()
                        }
                    }.offset(x: 10, y: 280)
                }
            }
            .padding()
        }
        .onAppear {
            // Update the initial values of latitude and longitude when the view appears
            latitude = "\(place.latitude)"
            longitude = "\(place.longitude)"
            checkMap()
        }

    }
    
    func checkAddress() {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(place.name ?? "") { placemarks, error in
            guard let placemark = placemarks?.first, let location = placemark.location else {
                // Handle error or show an alert
                return
            }
            let coordinate = location.coordinate
            model.latitude = coordinate.latitude
            model.longitude = coordinate.longitude
            model.fromLocToAddress()
            model.setupRegion()
            place.latitude = coordinate.latitude
            place.longitude = coordinate.longitude
            viewModel.savePlace(place: place)
        }
        checkMap()
    }

    
    func checkLocation() {
        model.longStr = longitude
        model.latStr = latitude
        model.fromLocToAddress()
        model.setupRegion()
        place.latitude = model.latitude
        place.longitude = model.longitude
        viewModel.savePlace(place: place)
        checkMap()
    }
    
    func checkZoom() {
        checkMap()
        model.fromZoomToDelta(zoom)
        model.fromLocToAddress()
        model.setupRegion()
        place.latitude = model.latitude
        place.longitude = model.longitude
        viewModel.savePlace(place: place)
    }
    
    func checkMap() {
        model.updateFromRegion()
        latitude = model.latStr
        longitude = model.longStr
        place.latitude = model.latitude
        place.longitude = model.longitude
        model.fromLocToAddress()
        viewModel.savePlace(place: place)
    }
}
