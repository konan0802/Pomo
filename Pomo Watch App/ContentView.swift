//
//  ContentView.swift
//  Pomo Watch App
//
//  Created by 小南佑介 on 2023/01/05
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            Spacer()
            ProgressCircle(limit: 1500, progress: 1255)
            HStack{
                RunningTask()
                Spacer()
                OperateTask()
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
                .font(.largeTitle)
                .fontWeight(.medium)
                //.foregroundColor(Color.green)
        }
    }
}

struct RunningTask: View {
    var body: some View {
        Text("MTG")
            .onTapGesture {
                print("MTG中です")
            }
    }
}

struct OperateTask: View {
    var body: some View {
        Text("•••")
            .onTapGesture {
                print("動いてますか")
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
