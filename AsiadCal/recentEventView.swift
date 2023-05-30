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
                .offset(x: -80)
            
            List {
                ForEach(subscribedAsiadEvents){
                    event in
                    if(event.EventDate >= Date()){
                        VStack{
                            HStack {
                                Text(event.EventName)
                                    .font(.system(size: 15))
                                    .frame(height: 30)
                                Spacer()
                                Divider()
                                    .frame(minWidth: 5)
                                    .overlay(Color(Event2Color[event.EventType]!))
                                Text(
                                    event.EventDate.formatted(
                                        date: .abbreviated,
                                        time: .shortened
                                    )
                                )
                                    .font(.system(size: 15))
                            }
                            
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation {
                                selectedEvent = event
                                viewDetail = true
                            }
                        }
                        
                    }
                }
                .listRowBackground(Color(red: 0.9, green: 0.9, blue: 0.9))
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
