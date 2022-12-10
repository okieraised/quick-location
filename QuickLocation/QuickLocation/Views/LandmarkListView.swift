//
//  LandmarkListView.swift
//  QuickLocation
//
//  Created by Tri Pham on 2/3/22.
//

import SwiftUI

struct LandmarkListView: View {
    
    let landmarks: [LandmarkViewModel]
    
    var body: some View {
        
        List(landmarks, id: \.id) { landmark in
            VStack(alignment: .leading, spacing: 10) {
                Text(landmark.name)
                    .font(.headline)
                Text(landmark.title)
            }.listStyle(GroupedListStyle())
            
            
        }
    }
}
