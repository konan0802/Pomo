//
//  TopView.swift
//  Pomo Watch App
//
//  Created by 小南佑介 on 2023/02/05.
//

import SwiftUI

struct TopView: View {
    
    @ObservedObject var display: Display
    @ObservedObject var timerViewModel: TimerViewModel

    var body: some View {
        VStack{
            Spacer()
            ProgressCircle(timerViewModel: self.timerViewModel)
            Spacer()
            HStack{
                RunningTask(display: self.display, timerViewModel: self.timerViewModel)
                Spacer()
                OperateTask(display: self.display)
            }
        }
    }
}

struct ProgressCircle: View {
    
    @ObservedObject var timerViewModel: TimerViewModel
    
    var body: some View {
        
        ZStack{
            Circle()
                .trim(from: 0, to: Double(timerViewModel.timer.duration) / Double(timerViewModel.timer.limit))
                .stroke(style: StrokeStyle(lineWidth: 18, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color(red: timerViewModel.timer.color.r, green: timerViewModel.timer.color.g, blue: timerViewModel.timer.color.b))
                .rotationEffect(Angle(degrees: -90))
                .frame(width: 125, height: 125)
            Text(String(format: "%02d:%02d", timerViewModel.timer.duration / 60, timerViewModel.timer.duration - ((timerViewModel.timer.duration / 60) * 60)))
                .font(.system(size: 34, weight: .medium))
        }
    }
}

struct RunningTask: View {
    
    @ObservedObject var display: Display
    @ObservedObject var timerViewModel: TimerViewModel
    
    var body: some View {
        Text(timerViewModel.timer.name)
            .onTapGesture {
                display.taskViewOn = true
            }
            .font(.system(size: 13))
            .frame(width: 150, height: 13)
    }
}

struct OperateTask: View {
    @ObservedObject var display: Display
    
    var body: some View {
        Text("•••")
            .onTapGesture {
                display.operateViewOn = true
            }
    }
}

/*
struct TopView_Previews: PreviewProvider {
    
    @ObservedObject var display = Display()
    
    static var previews: some View {
        TopView(display: self.display)
    }
}
*/
