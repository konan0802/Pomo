//
//  CurrentTaskViewModel.swift
//  Pomo Watch App
//
//  Created by 小南佑介 on 2023/02/06.
//

import Foundation
import Combine

class TimerViewModel: ObservableObject {
    
    @Published var timer: PomoTimer
    private var task: TaskToggl
    
    private let url = URL(string: "https://api.track.toggl.com/api/v9/me/time_entries/current")!
    private let str = "4f5a97b5555c23ba00eaa7da624a7ade:api_token"
    
    init() {
        self.timer = PomoTimer(name: "", duration: 0, limit: 1500, color: CororRGB(r: 0.024, g: 0.702, b: 0.286))
        self.task = TaskToggl(id: 0, workspaceId: 0, projectId: 0, duration: 0, description: "")
        
        fetchCurrentTaskFromTogglAPI()
        
        // 1s間隔でタイマーをカウントアップ
        Timer.scheduledTimer(timeInterval: 1.0,target: self,selector: #selector(countUp),userInfo: nil,repeats: true)
        // 10s間隔でAPIから実時間を取得
        Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(fetchCurrentTaskFromTogglAPI), userInfo: nil, repeats: true)
        // タイマー状態をチェック
        Timer.scheduledTimer(timeInterval: 1.0,target: self,selector: #selector(checkTimer),userInfo: nil,repeats: true)
    }

    @objc private func countUp() {
        if(self.task.description != "---") {
            self.timer.duration += 1
        }
    }
    
    @objc private func fetchCurrentTaskFromTogglAPI() {
        /// URLの生成
        let data: Data = str.data(using: .utf8)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Basic " + data.base64EncodedString(), forHTTPHeaderField: "Authorization")

        /// URLにアクセス
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            let data = data!
            let decoder = JSONDecoder()
            guard let decodedResponse = try? decoder.decode(TaskToggl.self, from: data) else {
                self.timer = PomoTimer(name: "---", duration: 0, limit: 1500, color: CororRGB(r: 0, g: 0.533, b: 0.2))
                self.task = TaskToggl(id: 0, workspaceId: 0, projectId: 0, duration: 0, description: "")
                return
            }
            DispatchQueue.main.async {
                self.task = decodedResponse
                self.convertPomoTimer()
            }

        }.resume()
    }

    private func convertPomoTimer() {
        // nameの設定
        self.timer.name = self.task.description
        
        // limitの設定
        switch self.task.description {
            case Constants.MTG:
                self.timer.limit = 3600
            case Constants.SBR:
                self.timer.limit = 300
            case Constants.LBR:
                self.timer.limit = 900
            default:
                self.timer.limit = 1500
        }
        
        // durationの計算
        let date = Date()
        let unixtime = Int(date.timeIntervalSince1970)
        self.timer.duration = unixtime + self.task.duration
    }
    
    @objc private func checkTimer() {
        if(self.timer.duration >= self.timer.limit) {
            self.timer.color = CororRGB(r: 1.0, g: 0, b: 0)
        }
    }
}
