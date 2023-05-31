
/*
import Foundation
import SwiftUI
import MapKit

extension MapEditorView{

    
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
            
            // Set zoom to 50% after updating the location
            zoom = 30.0
            checkZoom()
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
        zoom = 30.0
        checkZoom()
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
        
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: model.latitude, longitude: model.longitude)
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            guard let placemark = placemarks?.first, error == nil else {
                // Handle error or show an alert
                return
            }
            
            DispatchQueue.main.async {
                place.name = placemark.name
                place.latitude = model.latitude
                place.longitude = model.longitude
                viewModel.savePlace(place: place)
            }
        }
    }
    
}
*/
