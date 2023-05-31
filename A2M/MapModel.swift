

    import Foundation
    import CoreLocation
    import SwiftUI
    import MapKit

    extension MyLocation {
        var latStr: String {
            get{String(format: "%.5f", latitude)}
            set{
                guard let lat = Double(newValue), lat <= 90.0, lat >= -90.0 else {return}
                latitude = lat
            }
        }
        var longStr: String {
            get{String(format: "%.5f", longitude)}
            set{
                guard let long = Double(newValue), long <= 180.0, long >= -180.0 else {return}
                longitude = long
            }

        }
        
        func updateFromRegion() {
            latitude = region.center.latitude
            longitude = region.center.longitude
        }
        func setupRegion() {
            withAnimation {
                region.center.latitude = latitude
                region.center.longitude = longitude
                region.span.longitudeDelta = delta
                region.span.latitudeDelta = delta
            }
        }
        
        func fromLocToAddress() {
            let coder = CLGeocoder()
            coder.reverseGeocodeLocation(CLLocation(latitude: latitude, longitude: longitude)) { marks, error in
                if let err = error {
                    print("errof in fromLocToAddress: \(err)")
                    return
                }
                let mark = marks?.first
                let name = mark?.name ?? mark?.country ?? mark?.locality ?? mark?.administrativeArea ?? "No name"
                self.name = name
            }
            
        }
        
        func fromAddressToLoc() async {
            let encode = CLGeocoder()
            let marks = try? await encode.geocodeAddressString(self.name)
            
            if let mark = marks?.first {
                self.latitude = mark.location?.coordinate.latitude ?? self.latitude
                self.longitude = mark.location?.coordinate.longitude ?? self.longitude
                self.setupRegion()
            }
        }

        func fromAddressToLocOld(_ cb: @escaping ()->Void) {
            let encode = CLGeocoder()
            encode.geocodeAddressString(self.name) { marks, error in
                if let err = error {
                    print("errof in fromAddressToLoc \(err)")
                    return
                }
                if let mark = marks?.first {
                    self.latitude = mark.location?.coordinate.latitude ?? self.latitude
                    self.longitude = mark.location?.coordinate.longitude ?? self.longitude
                    cb()
                    self.setupRegion()
                }
            }
        }

        
        func fromZoomToDelta(_ zoom: Double){
            let c1 = -10.0
            let c2 = 3.0
            delta = pow(10.0, zoom / c1 + c2)
        }
        
        


        func reverseGeocode() {
                let coder = CLGeocoder()
                coder.reverseGeocodeLocation(CLLocation(latitude: region.center.latitude, longitude: region.center.longitude)) { marks, error in
                    if let err = error {
                        print("error in reverseGeocode: \(err)")
                        return
                    }

                    if let mark = marks?.first {
                        self.country = mark.country
                        self.postalCode = mark.postalCode
                    }
                }
            }


}
