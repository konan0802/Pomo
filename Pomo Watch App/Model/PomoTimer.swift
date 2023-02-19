//
//  CurrentTaskViewModel.swift
//  Pomo Watch App
//
//  Created by 小南佑介 on 2023/02/06.
//

import Foundation
import Combine

struct CororRGB: Decodable {
    var r: Double
    var g: Double
    var b: Double
}

class PomoTimer: ObservableObject {
        
    @Published var name = "---"
    @Published var duration = 0
    @Published var limit = 1500
    @Published var timeEntryId = 0
    @Published var color = CororRGB(r: 0.024, g: 0.702, b: 0.286)

    private var togglAPI = TogglAPI()
    
    init() {

        fetchCurrentTaskFromTogglAPI()
        
        // 1s間隔でタイマーをカウントアップ
        Timer.scheduledTimer(timeInterval: 1.0,target: self,selector: #selector(countUp),userInfo: nil,repeats: true)
        // 10s間隔でAPIから実時間を取得
        Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(fetchCurrentTaskFromTogglAPI), userInfo: nil, repeats: true)
        // タイマー状態をチェック
        Timer.scheduledTimer(timeInterval: 1.0,target: self,selector: #selector(checkTimer),userInfo: nil,repeats: true)
    }

    @objc private func countUp() {
        if (self.name != "---") {
            self.duration += 1
        }
    }
    
    @objc private func fetchCurrentTaskFromTogglAPI() {
        togglAPI.fetchCurrentEvent(conv: {(task:TogglTask) in
            
            if (task.description != "---") {
                // nameの設定
                self.name = task.description

                // durationの計算
                let date = Date()
                let unixtime = Int(date.timeIntervalSince1970)
                self.duration = unixtime + task.duration
                
                // limitの設定
                switch task.description {
                case Constants.MTG:
                    self.limit = 3600
                case Constants.SBR:
                    self.limit = 300
                case Constants.LBR:
                    self.limit = 900
                default:
                    self.limit = 1500
                }
                
                // time_entry_idの設定
                self.timeEntryId = task.id
                
            } else {
                self.name = "---"
                self.duration = 0
                self.limit = 1500
                self.timeEntryId = 0
                self.color = CororRGB(r: 0.024, g: 0.702, b: 0.286)

            }
        })
    }
    
    @objc private func checkTimer() {
        if(self.duration >= self.limit) {
            self.color = CororRGB(r: 1.0, g: 0, b: 0)
        }
    }
}
