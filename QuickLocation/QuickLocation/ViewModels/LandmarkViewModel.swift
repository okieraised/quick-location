//
//  LandmarkViewModel.swift
//  QuickLocation
//
//  Created by Tri Pham on 2/3/22.
//

import Foundation
import MapKit
import Contacts


struct LandmarkViewModel: Identifiable {
    
    let placemark: MKPlacemark
    
    let id = UUID()
    
    var name: String {
        placemark.name ?? ""
    }
    
    var title: String {
        placemark.title ?? ""
    }
    
    
    var coordinate: CLLocationCoordinate2D {
        placemark.coordinate
    }
}

