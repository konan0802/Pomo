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
    
    @ObservedObject var display = Display()
    @ObservedObject var timerViewModel = TimerViewModel()

    var body: some View {
        ZStack {
            
            TopView(display: self.display, timerViewModel: self.timerViewModel)
            
            if display.taskViewOn {
                TaskView(display: self.display)
            }else if display.operateViewOn {
                OperateView(display: self.display)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
