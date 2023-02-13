//
//  TopView.swift
//  Pomo Watch App
//
//  Created by 小南佑介 on 2023/02/05.
//

import SwiftUI

struct TopView: View {
    
    @ObservedObject var currentTaskStore: CurrentTaskStore?
    currentTaskStore = CurrentTaskStore();
    @ObservedObject var display: Display
    
    currentTaskStore = CurrentTaskStore()
    
    var body: some View {
        VStack{
            Spacer()
            ProgressCircle(limit: 1500, progress: currentTaskStore.task.duration!)
            HStack{
                RunningTask(display: self.display)
                Spacer()
                OperateTask(display: self.display)
            }
        }
    }
}

struct ProgressCircle: View {
    var limit: Int // 秒
    var progress: Int // 秒
    
    var body: some View {
        let value = Double(progress) / Double(limit) //　割合
        let min = progress / 60 // 分
        let sec = progress - (min * 60) //時間
        ZStack{
            Circle()
                .trim(from: 0, to: value)
                .stroke(style: StrokeStyle(lineWidth: 18, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.green)
                .rotationEffect(Angle(degrees: -90))
                .frame(width: 132, height: 132)
            Text(String(format: "%02d:%02d", min, sec))
                .font(.system(size: 36, weight: .medium))
                //.foregroundColor(Color.green)
        }
    }
}

struct RunningTask: View {
    
    @ObservedObject var display: Display
    
    var body: some View {
        Text("MTG")
            .onTapGesture {
                display.taskViewOn = true
                print("aa")
            }
    }
}

struct OperateTask: View {
    @ObservedObject var display: Display
    
    var body: some View {
        Text("•••")
            .onTapGesture {
                display.operateViewOn = true
                print("ab")
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
