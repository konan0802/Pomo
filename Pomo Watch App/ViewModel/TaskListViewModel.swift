//
//  TaskListViewModel.swift
//  Pomo Watch App
//
//  Created by 小南佑介 on 2023/02/13.
//

import Foundation

class TaskListViewModel: ObservableObject {
    
    @Published var tasks: [TaskSS]
    
    init() {
        self.tasks = [TaskSS(name: "---")]
    }
}
