//
//  ProfilePhotoView.swift
//  AsiadCal
//
//  Created by ChenSir on 2023/6/3.
//

import SwiftUI

struct ImageButton : View {
    var imageName : String
    @Binding var profilePhotoName : String
    var body: some View {
        Button {
            withAnimation {
                profilePhotoName = imageName
            }
        } label: {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .offset(y: 10)
                .frame(width: 100, height: 100)
                .clipShape(Circle())
        }
    }
}

struct ProfilePhotoView: View {
    @Binding var profilePhotoName : String
    var body: some View {
        ZStack {
            HStack {
                ImageButton(imageName: "lianlian", profilePhotoName: $profilePhotoName)
                ImageButton(imageName: "congcong", profilePhotoName: $profilePhotoName)
                ImageButton(imageName: "chenchen", profilePhotoName: $profilePhotoName)
            }
//            .offset(y: -200)
        }
    }
}

struct ProfilePhotoView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePhotoView(profilePhotoName: .constant("lianlian"))
    }
}
