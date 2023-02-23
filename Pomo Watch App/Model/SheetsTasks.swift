//
//  SheetsTasks.swift
//  Pomo Watch App
//
//  Created by 小南佑介 on 2023/02/19.
//

import Foundation

class SheetsTasks: ObservableObject {
    
    @Published var tasks = [""]
    
    private var sheetsAPI = SheetsAPI()
    
    init() {
        fetchTodayTasksFromSheetsAPI()
    }
    
    @objc private func fetchTodayTasksFromSheetsAPI() {
        sheetsAPI.fetchTodayTasks(conv: {(resp:SheetsApiResponse) in
            
            if (resp.range != "") {
                // tasksの設定
                self.tasks = resp.values[0]
                
            } else {
                self.tasks = [""]

            }
        })
    }
}
