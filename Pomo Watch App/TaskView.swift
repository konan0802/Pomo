//
//  TaskView.swift
//  Pomo Watch App
//
//  Created by 小南佑介 on 2023/01/29.
//

import SwiftUI

struct TaskView: View {
    
    @ObservedObject var display: Display

    var body: some View {
        ZStack {
            Color.black
                 .ignoresSafeArea()

            VStack {
                Text("＜")
                    .onTapGesture {
                        display.taskViewOn = false
                    }
     
                Text("TaskView!")
            }
        }
    }
}

/*
struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView()
    }
}
*/
