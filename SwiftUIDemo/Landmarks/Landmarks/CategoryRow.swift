
//
//  CategoryRow.swift
//  Landmarks
//
//  Created by hscai on 2019/11/14.
//  Copyright © 2019 HSCOO. All rights reserved.
//

import SwiftUI

struct CategoryRow: View {

    var categoryName: String
    var items: [Landmark]

    var body: some View {
        VStack(alignment: .leading) {
            Text(self.categoryName)
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)

            ScrollView(.horizontal, showsIndicators: false){
                HStack(alignment: .top, spacing: 0) {
                    ForEach(self.items){landmark in
                        NavigationLink(destination: LandmarkDetail(landmark: landmark)) {
                            CategoryItem(landmark: landmark)
                        }
                    }
                }
            }
        }
    }
}

struct CategoryItem: View {
    var landmark: Landmark
    var body: some View{
        VStack(alignment: .leading) {
            landmark.image
            .renderingMode(.original)
            .resizable()
            .frame(width: 155, height: 155)
            .cornerRadius(5)

        Text(landmark.name)
            .foregroundColor(.primary)
            .font(.caption)
        }
        .padding(.leading, 15)
        .padding(.bottom)
    }
}

struct CategoryRow_Previews: PreviewProvider {
    static var previews: some View {
        CategoryRow(
            categoryName: landmarkData[0].category.rawValue,
            items: Array(landmarkData.prefix(3))
        )
    }
}
