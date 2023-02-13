//
//  CurrentTaskViewModel.swift
//  Pomo Watch App
//
//  Created by 小南佑介 on 2023/02/06.
//

import Foundation
import Combine

class CurrentTaskViewModel: ObservableObject {
    var task: Task

    init() {
        self.task = Task(
            id: 0,
            workspaceId: 0,
            projectId: 0,
            duration: 1255,
            description: "MTGGGG"
        )
        load()
    }

    func load() {
        /// URLの生成
        let url = URL(string: "https://api.track.toggl.com/api/v9/me/time_entries/current")!
        let str = "****:api_token"
        let data: Data = str.data(using: .utf8)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Basic " + data.base64EncodedString(), forHTTPHeaderField: "Authorization")

        /// URLにアクセス
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data = data {
                let decoder = JSONDecoder()
                guard let decodedResponse = try? decoder.decode(Task.self, from: data) else {
                    print("JSON decode error")
                    return
                }
                DispatchQueue.main.async {
                    self.task = decodedResponse
                }
            } else {
                print("Fetched failed \(error?.localizedDescription ?? "UnknownError")")
            }
        }.resume()
    }
}
