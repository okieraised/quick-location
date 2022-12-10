//
//  ContentView.swift
//  QuickLocation
//
//  Created by Tri Pham on 2/3/22.
//

import SwiftUI
import MapKit

enum DisplayType {
    case map
    case list
}

struct ContentView: View {
    
    @StateObject private var placeListVM = PlaceListViewModel()
    @State private var userTrackingMode: MapUserTrackingMode = .follow
    @State private var searchTerm: String = ""
    @State private var displayType: DisplayType = .map
    @State private var isDragged: Bool = false
    
    private func getRegion() -> Binding<MKCoordinateRegion> {
        guard let coordinate = placeListVM.currentLocation else {
            return .constant(MKCoordinateRegion.defaultRegion)
        }
        return .constant(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)))
    }
    
    private func userDistance(from point: CLLocationCoordinate2D) -> String {
        guard let userLocation = placeListVM.currentLocation else {
            return "" // User location unknown!
        }
        
        let toLocation = CLLocation(
            latitude:  userLocation.latitude,
            longitude: userLocation.longitude
        )

        let fromLocation = CLLocation(
            latitude:  point.latitude,
            longitude: point.longitude
        )
        
        let distance: Double = toLocation.distance(from: fromLocation) / 1000
        
        return String(format: "%.2f km", distance)
    }
    
    var body: some View {
        VStack {
            TextField(
                "Search",
                text: $searchTerm,
                onEditingChanged: { _ in},
                onCommit: {
                    placeListVM.searchLandmarks(searchTerm: searchTerm)
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            
            LandmarkCategoryView { (category) in
                placeListVM.searchLandmarks(searchTerm: category)
                
            }
            
            Picker("Select", selection: $displayType) {
                Text("Map").tag(DisplayType.map)
                Text("List").tag(DisplayType.list)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            if displayType == .map {
                
                Map(coordinateRegion: getRegion(),
                    interactionModes: .all,
                    showsUserLocation: true,
                    userTrackingMode: $userTrackingMode,
                    annotationItems: placeListVM.landmarks) { landmark in
                    
                    MapAnnotation(coordinate: landmark.coordinate) {
                        HStack {
                            Image(systemName: "mappin.circle.fill")
                                .font(.system(size: 12))
                                .foregroundColor(.red)
                            Text(landmark.name)
                                .minimumScaleFactor(0.1)
                                .font(.system(size: 12))
                            Text(userDistance(from: landmark.coordinate))
                                .minimumScaleFactor(0.1)
                                .font(.system(size: 12))
                        }
                        .padding(10)
                        .background(.white.opacity(0.5))
                        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                        
                    }
                }
                
                
                //                    MapMarker(coordinate: landmark.coordinate)
                    .gesture(DragGesture()
                                .onChanged({ (value) in
                        isDragged = true
                    })
                    )
                    .overlay(isDragged ? AnyView(RecenterButtonView {
                        placeListVM.startUpdatingLocation()
                        isDragged = false
                    }.padding()): AnyView(EmptyView()),alignment: .bottom)
                
            } else if displayType == .list {
                LandmarkListView(landmarks: placeListVM.landmarks)
            }
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            alignment: .topLeading
          )
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
