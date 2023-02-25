//
//  TaskView.swift
//  Pomo Watch App
//
//  Created by 小南佑介 on 2023/01/29.
//

import SwiftUI

struct TaskView: View {
    
    @EnvironmentObject var display: Display
    @StateObject var sheetsTasks = SheetsTasks()
    
    var togglAPI = TogglAPI()

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                HStack{
                    Text("< Back")
                        .onTapGesture {
                            display.taskViewOn = false
                        }
                        .frame(height: 6)
                    Spacer()
                }
                NavigationView {
                    List(sheetsTasks.tasks, id: \.self) { task in
                        Text(task)
                            .onTapGesture {
                                Task{
                                    await togglAPI.startEvent(taskName: task)
                                    display.taskViewOn = false
                                }
                            }
                    }
                    .navigationBarTitle("")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarHidden(true)
                }
                Spacer()
                
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
