//
//  LandmarkCategoryView.swift
//  QuickLocation
//
//  Created by Tri Pham on 2/3/22.
//

import SwiftUI

struct LandmarkCategoryView: View {
    
    let categories = ["Groceries", "Pharmacies", "Gas", "Restaurants", "Coffee", "Hotel", "Mall"]
    let onSelectedCategory: (String) -> ()
    
    @State private var selectedCategory: String = ""
    
    var body: some View {
        ScrollView(.horizontal) {
            
            HStack {
                ForEach(categories, id: \.self) { category in
                    
                    Button(
                        action: {
                            selectedCategory = category
                            onSelectedCategory(category)
                        },
                        label: {
                            Text(category)
                        }
                    )
                        .padding(10)
                        .foregroundColor(selectedCategory == category ? Color.white: Color.black)
                        .background(selectedCategory == category ? Color.gray: Color.green)
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                }
                
            }
        }
    }
}

struct LandmarkCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkCategoryView(onSelectedCategory: { _ in })
    }
}
