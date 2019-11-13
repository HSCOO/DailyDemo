//
//  LandmarkDetail.swift
//  Landmarks
//
//  Created by hscai on 2019/11/13.
//  Copyright © 2019 HSCOO. All rights reserved.
//

import SwiftUI

struct LandmarkDetail: View {
    @EnvironmentObject var userData: UserData
    var landmark: Landmark

    var landmarkIndex: Int{//被标记喜欢的序号
        userData.landmarks.firstIndex(where: {$0.id == landmark.id})!
    }

    var body: some View {
        VStack {
            MapView(coordinate: landmark.locationCoordinate)
                .frame(height:  300)
                .edgesIgnoringSafeArea(.top)
            //
            CircleImage(image: landmark.image)
                .offset(y: -200)
                .padding(.bottom, -200)
            //
            VStack(alignment: .leading) {
                HStack {
                    Text(landmark.name)
                        .font(.title)
                    Button(action: {
                        self.userData.landmarks[self.landmarkIndex].isFavorite.toggle()
                    }) {
                        if self.userData.landmarks[self.landmarkIndex].isFavorite{
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                        }else{
                            Image(systemName: "star")
                            .foregroundColor(.gray)
                        }
                    }
                }
                HStack {
                    Text(landmark.park)
                        .font(.caption)
                    Spacer()
                    Text(landmark.state)
                    .font(.caption)
                }
            }
            .padding()
            Spacer()
        }
        .navigationBarTitle(Text(landmark.name), displayMode: .inline)
    }
}

struct LandmarkDetail_Preview: PreviewProvider {
    static var previews: some View {
        let userData = UserData()
        return LandmarkDetail(landmark: userData.landmarks[0])
            .environmentObject(userData)
    }
}
