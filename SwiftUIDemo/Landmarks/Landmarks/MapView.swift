//
//  MapView.swift
//  Landmarks
//
//  Created by hscai on 2019/11/13.
//  Copyright © 2019 HSCOO. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {

    var coordinate: CLLocationCoordinate2D

    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        view.setRegion(region, animated: true)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(coordinate: landmarkData[1].locationCoordinate)
    }
}
