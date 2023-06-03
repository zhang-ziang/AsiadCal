//
//  UserView.swift
//  AsiadCal
//
//  Created by ChenSir on 2023/6/2.
//

import SwiftUI

//struct ProfilePhotoView : View {
//    var body: some View {
//        Text("hello")
//    }
//}

//struct BackGroundView : View {
//    var body: some View {
//        Text("hello")
//    }
//}

struct UserView: View {
    @Binding var curView : NvgState
    @Binding var GlobeBackGroundName : String
    @State var profilePhotoName : String = "lianlian"
    @State var userName : String = "Lian Lian"
    @State var hideProfilePhoto : Bool = false
    var body: some View {
        if(curView == .atUserSettingView){
            VStack{
                VStack{
                    Image(profilePhotoName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .offset(y: 10)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                    Text(userName)
                }
                .opacity(hideProfilePhoto ? 0.0 : 1.0)
                
                NavigationView{
                    List {
                            
                            
//                        NavigationLink(destination: {
//                            ProfilePhotoView(profilePhotoName: $profilePhotoName)
//                        }, label: {
//                            Label("头像", systemImage: "person.crop.circle.fill")
//                        }, value: $hideProfilePhoto)

//                        VStack{
                            NavigationLink {
                                ProfilePhotoView(profilePhotoName: $profilePhotoName)
                            } label: {
                                Label("头像", systemImage: "person.crop.circle.fill")
                            }
                            .listRowBackground(Color(red: 0.96, green: 0.96, blue: 0.96))

                            
                            NavigationLink {
                                BackGroundView(GlobeBackGroundName: $GlobeBackGroundName)
                            } label: {
                                Label("背景", systemImage: "paintpalette.fill")
                            }
                            .listRowBackground(Color(red: 0.96, green: 0.96, blue: 0.96))
                            
                            NavigationLink {
        //                        ProfilePhotoView()
                            } label: {
                                Label("无障碍", systemImage: "ear.fill")
                            }
                            .listRowBackground(Color(red: 0.96, green: 0.96, blue: 0.96))
//                        }
                        
                    }
                    
                    .navigationTitle("Setting")
                }
//                .offset(y: -50)
            }
//            .listRowBackground(Color(red: 0.96, green: 0, blue: 0))
            .scrollContentBackground(.hidden)
            .frame(width: 380, height: 600)
//            .offset(y: -60)
            .transition(.opacity)
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(curView: .constant(.atUserSettingView), GlobeBackGroundName: .constant("giphy.gif"))
    }
}
