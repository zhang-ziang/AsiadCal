//
//  recentEventView.swift
//  AsiadCal
//
//  Created by ChenSir on 2023/5/30.
//

import SwiftUI

struct recentEventView: View {
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
                            
                        }
                        .frame(width : 330)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation {
                                selectedEvent = event
                                viewDetail = true
                            }
                        }
                        
                    }
                }
                .listRowBackground(Color(red: 0.96, green: 0.96, blue: 0.96))
            }
            .scrollContentBackground(.hidden)
        }
//        .frame(height: 500)
//        .offset(y: -130)
//        .zIndex(10.0)
    }
}

struct recentEventView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            recentEventView(selectedEvent: subscribedAsiadEvents.first)
        }
    }
}
