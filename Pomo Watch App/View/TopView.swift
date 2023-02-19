//
//  TopView.swift
//  Pomo Watch App
//
//  Created by 小南佑介 on 2023/02/05.
//

import SwiftUI

struct TopView: View {

    var body: some View {
        VStack{
            Spacer()
            ProgressCircle()
            Spacer()
            HStack{
                RunningTask()
                Spacer()
                OperateTask()
            }
        }
    }
}

struct ProgressCircle: View {
    
    @EnvironmentObject var pomoTimer: PomoTimer
    
    var body: some View {
        
        ZStack{
            Circle()
                .trim(from: 0, to: Double(pomoTimer.duration) / Double(pomoTimer.limit))
                .stroke(style: StrokeStyle(lineWidth: 18, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color(red: pomoTimer.color.r, green: pomoTimer.color.g, blue: pomoTimer.color.b))
                .rotationEffect(Angle(degrees: -90))
                .frame(width: 125, height: 125)
            Text(String(format: "%02d:%02d", pomoTimer.duration / 60, pomoTimer.duration - ((pomoTimer.duration / 60) * 60)))
                .font(.system(size: 34, weight: .medium))
        }
    }
}

struct RunningTask: View {
    
    @EnvironmentObject var display: Display
    @EnvironmentObject var pomoTimer: PomoTimer
    
    var body: some View {
        Text(pomoTimer.name)
            .onTapGesture {
                display.taskViewOn = true
            }
            .font(.system(size: 13))
            .frame(width: 150, height: 13, alignment: .leading)
    }
}

struct OperateTask: View {
    @EnvironmentObject var display: Display
    
    var body: some View {
        Text("•••")
            .onTapGesture {
                display.operateViewOn = true
            }
            .frame(height: 13)
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
