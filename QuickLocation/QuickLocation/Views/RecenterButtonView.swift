//
//  RecenterButtonView.swift
//  QuickLocation
//
//  Created by Tri Pham on 2/3/22.
//

import SwiftUI

struct RecenterButtonView: View {
    
    let onTapped: () -> ()
    
    var body: some View {
        Button(
            action: onTapped,
            label: {
                Label("Recenter", systemImage: "arrow.uturn.backward")
            }
        )
            .padding(10)
            .foregroundColor(.white)
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        
    }
}

struct RecenterButtonView_Previews: PreviewProvider {
    static var previews: some View {
        RecenterButtonView(onTapped: {})
    }
}
