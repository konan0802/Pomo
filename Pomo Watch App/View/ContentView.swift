//
//  ContentView.swift
//  Pomo Watch App
//
//  Created by 小南佑介 on 2023/01/05
//

import SwiftUI

final class Display: ObservableObject {
    @Published var taskViewOn = false
    @Published var operateViewOn = false
}

struct ContentView: View {
    
    @StateObject var display = Display()
    @StateObject var pomoTimer = PomoTimer()

    var body: some View {
        ZStack {
            
            TopView()
                .environmentObject(display)
                .environmentObject(pomoTimer)
            
            if display.taskViewOn {
                TaskView()
                    .environmentObject(display)
                    .environmentObject(pomoTimer)
            }else if display.operateViewOn {
                OperateView()
                    .environmentObject(display)
                    .environmentObject(pomoTimer)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
