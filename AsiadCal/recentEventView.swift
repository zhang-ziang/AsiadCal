//
//  recentEventView.swift
//  AsiadCal
//
//  Created by ChenSir on 2023/5/30.
//

import SwiftUI

struct recentEventView: View {
    @Binding var refreshList : Bool
    @State var selectedEvent : AsiadEvent?
    @State var viewDetail : Bool = false
    
    var body: some View {
        VStack {
            Text("Recent Events")
                .font(.system(size: 30))
                .offset(x: -80, y: 20)
            
            List {
                ForEach(subscribedAsiadEvents){
                    event in
                    if(event.EventDate >= Date()){
                        HStack {
                            Text(event.EventName)
                                .font(.system(size: 15))
                                .frame(height: 40)
                            Spacer()
                            Divider()
                                .frame(minWidth: 5)
                                .overlay(Color(Event2Color[event.EventType]!))
                            VStack{
                                HStack {
//                                    Spacer()
                                    
                                    ForEach(RecommandTravelMethod[event.EventPos]!) {
                                        mtd in
                                        Image(systemName: mtd.mtdName)
                                            .font(.system(size: 13))
                                    }
                                    
                                    
                                    Text(event.EventPos)
                                        .font(.system(size: 13))
                                    
                                }
                                Text(
                                    event.EventDate.formatted(
                                        date: .abbreviated,
                                        time: .shortened
                                    )
                                )
                                    .font(.system(size: 15))
                            }
                            .frame(width: 200)
                            
                            
                        }
//                        .frame(width : 330)
                        .frame(width: 330)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation {
                                selectedEvent = event
                                viewDetail = true
                            }
                        }
                        
                    }
                }
                .onDelete(perform: delete)
                .listRowBackground(Color(red: 0.96, green: 0.96, blue: 0.96))
                .onChange(of: refreshList){ _ in
                    
                }
            }
            .scrollContentBackground(.hidden)
        }
        .frame(width: 400)
//        .offset(y: -130)
//        .zIndex(10.0)
    }
    
    func delete(at offsets: IndexSet) {
//        users.remove(atOffsets: offsets)
        subscribedAsiadEvents.remove(atOffsets: offsets)
    }
}

struct recentEventView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            recentEventView(refreshList: .constant(true),selectedEvent: subscribedAsiadEvents.first)
        }
    }
}
