//
//  CalenderView.swift
//  Calendar
//
//  Created by ChenSir on 2023/5/15.
//

import SwiftUI
import UIKit
import FSCalendar

enum SportType {
    case Athletics
    case Basketball
    case CyclingRoad
    case Football
    case CyclingMTB
    case Boxing
    case Fencing
    case CanoeSlalom
    case DragonBoat
    case Swimming
    case ESport
}

struct AsiadEvent {
    var EventName : String
    var EventDate : Date
    var EventType : SportType
}

extension AnyTransition {
    static var moveAndScale: AnyTransition {
        AnyTransition.move(edge: .bottom)
//        AnyTransition.move.combined(with: .scale)
    }
}


struct CalendarView: View {
    
    @State var selectedDate: Date = Date()
    @State var showDetail: Bool = false
    @State var showEvent: Bool = true
    
    @State var eventPos: CGSize = CGSize(width: 0, height: 0)
    let enterEffect = CGAffineTransform(translationX: 0, y: 100)
    let quitEffect = CGAffineTransform(translationX: 0, y: 800)
    
    var tap: some Gesture {
        TapGesture(count: 1)
            .onEnded {
                withAnimation{
                    if(showDetail) {
                        showEvent = false
                    }
                }
            }
    }
    
    var body: some View {
        ZStack{
            if(showDetail) {
                ZStack{
                    RoundedRectangle(cornerRadius: 60)
                        .strokeBorder(.purple, lineWidth: 10)
                        .foregroundColor(.white)
                        .frame(height: 700)
                        .offset(x: 0,y: 80)
                        
                    CalendarViewRepresentable(selectedDate: $selectedDate, showEvent: $showEvent, eventPos: $eventPos)
                        .padding(.bottom)
                        .padding(EdgeInsets(top: 40, leading: 0, bottom: 0, trailing: 0))
                        .frame(width: 300, height: 600)
                        .offset(x:0, y:100)
                    
                }
                .transition(.move(edge: .bottom))
            }
            if(showDetail && showEvent) {
                ZStack{
                    RoundedRectangle(cornerRadius: 60)
                        .foregroundColor(.black)
                        .frame(height: 700)
                        .offset(x: 0,y: 80)
                        .opacity(0.001)
                        .gesture(tap)
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 350, height: 200)
                            .foregroundColor(.purple)
                            .offset(x: 0, y: 300)
                            .shadow(radius: 60)
                        VStack{
                            Text("test here 0")
                                .font(.system(size: 30))
                            Text("test here 1")
                                .font(.system(size: 30))
                            Text("test here 2")
                                .font(.system(size: 30))
                        }
                        .offset(y: 250)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                    }
                }
            }
            Button {
                withAnimation {
                    showDetail.toggle()
                    if(showDetail) {
                        showEvent = false
                    }
                }
            } label: {
                Label("Graph", systemImage: "chevron.right.circle")
                    .labelStyle(.iconOnly)
                    .imageScale(.large)
                    .rotationEffect(.degrees(showDetail ? 90 : -90))
                    .scaleEffect(2.0)
                    .padding()
            }.offset(x:0,y: -200)
            
        }
        
    }
}



struct CalendarViewRepresentable: UIViewRepresentable {
    typealias UIViewType = FSCalendar

    fileprivate var calendar = FSCalendar()
    @Binding var selectedDate: Date
    @Binding var showEvent: Bool
    @Binding var eventPos: CGSize
    
    
    func makeUIView(context: Context) -> FSCalendar {
        calendar.delegate = context.coordinator
        calendar.dataSource = context.coordinator

        // Added the below code to change calendar appearance
        calendar.appearance.todayColor = .gray
        calendar.appearance.titleTodayColor = .black
        calendar.appearance.selectionColor = .orange
        calendar.appearance.eventDefaultColor = .gray
        calendar.appearance.eventSelectionColor = .orange
        calendar.appearance.titleTodayColor = .white
        calendar.appearance.titleFont = .boldSystemFont(ofSize: 24)
//        calendar.appearance.titleWeekendColor = .systemOrange
        calendar.appearance.headerMinimumDissolvedAlpha = 0.12
        calendar.appearance.headerTitleFont = .systemFont(
                                                ofSize: 30,
                                                weight: .black)
        calendar.appearance.headerTitleColor = .darkGray
        calendar.appearance.borderRadius = 1
        //calendar.appearance.headerDateFormat = "MMMM"
        calendar.scrollDirection = .vertical
        calendar.scope = .month
        calendar.clipsToBounds = false
        


        return calendar
    }

    func updateUIView(_ uiView: FSCalendar, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    

    
    class Coordinator: NSObject,FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
        var parent: CalendarViewRepresentable

        var AsiadEvents : [AsiadEvent]
        
        var Event2Color : [SportType : UIColor] = [
            .Athletics  : .red ,
            .Basketball : .yellow ,
            .CyclingRoad: .brown ,
            .Football   : .orange ,
            .CyclingMTB : .blue ,
            .Boxing     : .red ,
            .Fencing    : .red ,
            .CanoeSlalom: .red ,
            .DragonBoat : .red ,
            .Swimming   : .red ,
            .ESport     : .purple
        ]
        
        init(_ parent: CalendarViewRepresentable) {
            self.parent = parent
            self.AsiadEvents = []
            // 在此load赛事日程
            AsiadEvents.append(
                AsiadEvent(EventName: "英雄联盟表演赛-中国vs韩国", EventDate: Date(), EventType: .ESport)
            )
            AsiadEvents.append(
                AsiadEvent(EventName: "足球赛-中国vs越南", EventDate: Date(), EventType: .Football)
            )
        }
        
        func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
            var EventColors : [UIColor] = []
            AsiadEvents.forEach { event in
                if event.EventDate.formatted(date: .complete, time: .omitted)
                    == date.formatted(date: .complete, time: .omitted){
                    EventColors.append(Event2Color[event.EventType]!)
                }
            }
            return EventColors
         }

        func calendar(_ calendar: FSCalendar,
                      didSelect date: Date,
                      at monthPosition: FSCalendarMonthPosition) {
            parent.selectedDate = date
            
            withAnimation {
                parent.showEvent = true
            }
        }
    

        func calendar(_ calendar: FSCalendar,
                  imageFor date: Date) -> UIImage? {
            return nil
        }

        func calendar(_ calendar: FSCalendar,
                      numberOfEventsFor date: Date) -> Int {
            
            var eventCount = 0
            AsiadEvents.forEach { event in
                if event.EventDate.formatted(date: .complete, time: .omitted)
                    == date.formatted(date: .complete, time: .omitted){
                    eventCount += 1;
                }
            }
            return eventCount
        }

        func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
            if isWeekend(date: date) {
                return true
            }
            return true
        }

        func maximumDate(for calendar: FSCalendar) -> Date {
            Date.now.addingTimeInterval(86400 * 30)
        }

        func minimumDate(for calendar: FSCalendar) -> Date {
            Date.now.addingTimeInterval(-86400 * 30)
        }
    }
}

func isWeekend(date: Date) -> Bool {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
    let day: String = dateFormatter.string(from: date)
    if day == "Saturday" || day == "Sunday" {
        return true
    }
    return false
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            CalendarView()
        }
    }

}
