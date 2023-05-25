//
//  MapView.swift
//  A2M
//
//  Created by Tsz Hoi Leung on 25/5/2023.
//

import Foundation
import MapKit


struct MapView: View {
    @State var coordinate: CLLocationCoordinate2D

    var body: some View {
        Map(coordinateRegion: $coordinate)
            .edgesIgnoringSafeArea(.all)
    }
}
