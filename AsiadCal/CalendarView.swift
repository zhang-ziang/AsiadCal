//
//  CalenderView.swift
//  Calendar
//
//  Created by ChenSir on 2023/5/15.
//

import SwiftUI
import UIKit
import FSCalendar
import SDWebImageSwiftUI


extension AnyTransition {
    static var moveAndScale: AnyTransition {
        AnyTransition.move(edge: .bottom)
//        AnyTransition.move.combined(with: .scale)
    }
}


struct CalendarView: View {
    
    @State var selectedDate: Date = Date()
    @Binding var showDetail: Bool
    @State var showEvent: Bool = false
    @State var isAnimated: Bool = true
    @State var eventPos: CGSize = CGSize(width: 0, height: 0)
    @State var eventTexts: [AsiadEvent] = []
    @State var isRotated : Bool = false
//    @State var animationAmount: Double = 0
    var tap: some Gesture {
        TapGesture(count: 1)
            .onEnded {
                withAnimation{
                    if(showDetail) {
                        showEvent = false
                        isRotated = false
                    }
                }
            }
    }
    var doubleTap: some Gesture {
        TapGesture(count: 2)
            .onEnded {
                withAnimation{
                    showDetail = false
                    showEvent = false
                    isRotated = false
                }
            }
    }
    
    var exitTap: some Gesture {
        TapGesture(count: 1)
            .onEnded {
                withAnimation{
                    showDetail = false
                    showEvent = false
                    isRotated = false
                }
            }
    }
    
    var body: some View {
        ZStack{
            
            Rectangle()
                .foregroundColor(.white)
                .blendMode(.multiply)
                .gesture(exitTap)
            if(showDetail && !showEvent) {
                HStack{
                    Image(systemName: "sun.max.fill")
                        .symbolRenderingMode(.hierarchical)
                        .foregroundColor(.yellow)
                        .font(.system(size: 80))
                        .shadow(radius: 5)
//                        .scaleEffect(isRotated)
                        .rotationEffect(.degrees(isRotated ? 360 : 0))
                        .animation(
                            .linear(duration: 40)
                                .repeatForever(autoreverses: false),
                            value: isRotated
                        )
                        .onAppear{
                            isRotated = true
                        }
                    VStack{
                        Text("34°C")
                            .font(.system(size: 40))
                        Text("西湖区 空气良")
                    }.shadow(radius: 5)
                }
                .offset(y: -300)
                .zIndex(6.0)
                .transition(.move(edge: .top).combined(with: .opacity))
            }
            if(showDetail) {
                ZStack{
                    AnimatedImage(name: "giphy.gif", bundle: Bundle.main, isAnimating: $isAnimated)
                        .playbackMode(.bounce)
                        .frame(width: 394, height: 800)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 60)
//                                .strokeBorder(lineWidth: 10)
                        )
                        
                        .shadow(radius: 10)
                        .offset(x: 0,y: 180)
                    RoundedRectangle(cornerRadius: 50)
//                        .strokeBorder(.purple, lineWidth: 10)
                        .foregroundColor(.white)
                        .frame(width: 374, height: 780)
                        .offset(x: 0,y: 180)
                    
                        
                    CalendarViewRepresentable(
                        selectedDate: $selectedDate,
                        showEvent: $showEvent,
                        isRotating: $isRotated,
                        eventPos: $eventPos,
                        eventTexts: $eventTexts
                    )
                        .padding(.bottom)
                        .padding(EdgeInsets(top: 40, leading: 0, bottom: 0, trailing: 0))
                        .frame(width: 300, height: 600)
                        .offset(x:0, y:70)
                        
                    
                }
                .zIndex(4.0)
                .offset(x:0, y:showEvent ? -100 : 0)
                .gesture(doubleTap)
                .transition(.move(edge: .bottom))
            }
            if(showDetail && showEvent) {
                ZStack{
                    
                    RoundedRectangle(cornerRadius: 60)
                        .foregroundColor(.white)
                        .frame(width: 394, height: 800)
                        .offset(x:0, y:showEvent ? -200 : 0)
                        .blendMode(.multiply)
                        .gesture(doubleTap)
                        .gesture(tap)
                        
                    ZStack(alignment: .leading){

                        
                        List(){
                            VStack{
                                if eventTexts.isEmpty {
                                    Text("Empty~")
                                        .font(.system(size: 15))
                                        .multilineTextAlignment(.center)
                                        
                                }
                                else {
                                    ForEach(eventTexts) { event in
                                        HStack{
                                            Text(event.EventName)
                                            .font(.system(size: 15))
                                            Spacer()
                                            Divider()
                                                .frame(minWidth: 5)
                                                .overlay(Color(Event2Color[event.EventType]!))
                                            Text(
                                                event.EventDate.formatted(
                                                    date: .omitted,
                                                    time: .shortened
                                                )
                                            )
                                            .font(.system(size: 15))
                                        }
                                    }
                                }
                            }
                        }
                        .navigationTitle("Events")
                        .frame(width: 300, height: 220)
                        .cornerRadius(20)
                        .shadow(radius: 5)
                        .gesture(doubleTap)
                    }
                }
                .offset(y: 280)
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .zIndex(5.0)
            }

            
        }
        
    }
}



struct CalendarViewRepresentable: UIViewRepresentable {
    typealias UIViewType = FSCalendar

    fileprivate var calendar = FSCalendar()
    @Binding var selectedDate: Date
    @Binding var showEvent: Bool
    @Binding var isRotating: Bool
    @Binding var eventPos: CGSize
    @Binding var eventTexts: [AsiadEvent]
    
    func makeUIView(context: Context) -> FSCalendar {
        calendar.delegate = context.coordinator
        calendar.dataSource = context.coordinator

        // Added the below code to change calendar appearance
        calendar.appearance.todayColor = .gray
        calendar.appearance.titleTodayColor = .black
        calendar.appearance.selectionColor = .orange
        calendar.appearance.eventDefaultColor = .gray
//        calendar.appearance.eventSelectionColor = .orange
//        calendar.appearance.eventDotDiameter = 5.0
        calendar.appearance.titleTodayColor = .white
        calendar.appearance.titleFont = .boldSystemFont(ofSize: 24)
//        calendar.appearance.titleWeekendColor = .systemOrange
        calendar.appearance.headerMinimumDissolvedAlpha = 0.12
        calendar.appearance.headerTitleFont = .systemFont(
                                                ofSize: 30,
                                                weight: .black)
        calendar.appearance.headerTitleColor = .darkGray
        calendar.appearance.borderRadius = 1
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
        
        init(_ parent: CalendarViewRepresentable) {
            self.parent = parent
        }
        
        func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
            var EventColors : [UIColor] = []
            subscribedAsiadEvents.forEach { event in
                if event.EventDate.formatted(date: .complete, time: .omitted)
                    == date.formatted(date: .complete, time: .omitted){
                    EventColors.append(Event2Color[event.EventType]!)
                }
            }
            return EventColors
         }
        
        func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventSelectionColorsFor date: Date) -> [UIColor]? {
            var EventColors : [UIColor] = []
            subscribedAsiadEvents.forEach { event in
                if event.EventDate.formatted(date: .complete, time: .omitted)
                    == date.formatted(date: .complete, time: .omitted){
                    EventColors.append(Event2Color[event.EventType]!)
                }
            }
            return EventColors
         }
        
        func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
            let eventScaleFactor: CGFloat = 1.5
            cell.eventIndicator.transform = CGAffineTransform(scaleX: eventScaleFactor, y: eventScaleFactor)
        }

        func calendar(_ calendar: FSCalendar,
                      didSelect date: Date,
                      at monthPosition: FSCalendarMonthPosition) {
            parent.selectedDate = date
            parent.eventTexts = []
            subscribedAsiadEvents.forEach { event in
                if event.EventDate.formatted(date: .complete, time: .omitted)
                    == date.formatted(date: .complete, time: .omitted){
                    parent.eventTexts.append(event)
                }
            }
            withAnimation {
                parent.showEvent = true
                parent.isRotating = false
            }
        }
    

        func calendar(_ calendar: FSCalendar,
                  imageFor date: Date) -> UIImage? {
            return nil
        }

        func calendar(_ calendar: FSCalendar,
                      numberOfEventsFor date: Date) -> Int {
            
            var eventCount = 0
            subscribedAsiadEvents.forEach { event in
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

//        func maximumDate(for calendar: FSCalendar) -> Date {
//            Date.now.addingTimeInterval(86400 * 30)
//        }
//
//        func minimumDate(for calendar: FSCalendar) -> Date {
//            Date.now.addingTimeInterval(-86400 * 30)
//        }
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
            CalendarView(showDetail: .constant(true))
        }
    }

}
