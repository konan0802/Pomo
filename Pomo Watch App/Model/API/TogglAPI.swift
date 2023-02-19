//
//  Toggl.swift
//  Pomo Watch App
//
//  Created by 小南佑介 on 2023/02/19.
//

import Foundation

/*
 {
   "id": 2831627986,
   "workspace_id": 5762183,
   "project_id": 184292335,
   "task_id": null,
   "billable": false,
   "start": "2023-02-05T06:03:23+00:00",
   "stop": null,
   "duration": -1675577004,
   "description": "Pomoの作成",
   "tags": [],
   "tag_ids": [],
   "duronly": true,
   "at": "2023-02-05T06:03:28+00:00",
   "server_deleted_at": null,
   "user_id": 7288804,
   "uid": 7288804,
   "wid": 5762183,
   "pid": 184292335
 }
 */
struct TogglTask: Decodable {
    var id: Int
    var workspaceId: Int?
    var projectId: Int?
    var duration: Int
    var description: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case workspaceId = "workspaceId"
        case projectId = "projectId"
        case duration = "duration"
        case description = "description"
    }
}

class TogglAPI {
    
    private let url = URL(string: "https://api.track.toggl.com/api/v9/me/time_entries/current")!
    private let str = "4f5a97b5555c23ba00eaa7da624a7ade:api_token"
    
    public func fetchCurrentEvent(conv:@escaping (TogglTask)->Void) {
        
        let url = URL(string: "https://api.track.toggl.com/api/v9/me/time_entries/current")
        
        var task = TogglTask(id: 0, workspaceId: 0, projectId: 0, duration: 0, description: "---")
        
        /// URLの生成
        let data: Data = str.data(using: .utf8)!
        var request = URLRequest(url: url!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Basic " + data.base64EncodedString(), forHTTPHeaderField: "Authorization")

        /// URLにアクセス
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            let data = data!
            let decoder = JSONDecoder()
            guard let decodedResponse = try? decoder.decode(TogglTask.self, from: data) else {
                conv(task)
                return
            }
            DispatchQueue.main.async {
                task = decodedResponse
                conv(task)
                return
            }

        }.resume()
    }
    
    public func startEvent(taskName: String) {
        
        let url = URL(string: "https://api.track.toggl.com/api/v9/workspaces/5762183/time_entries")
        
        /// URLの生成
        let authData: Data = str.data(using: .utf8)!
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Basic " + authData.base64EncodedString(), forHTTPHeaderField: "Authorization")
        
        let now = Date()
        let unixtime = -1 * Int(now.timeIntervalSince1970)
        let f = DateFormatter()
        f.locale = Locale(identifier: "ja_JP")
        f.timeZone = TimeZone(abbreviation: "UTC")
        f.dateFormat = "yyyy-MM-dd'T'HH:mm:ss+00:00"
        let start = f.string(from: now)
        
        let data: [String: Any] = [
            "created_with": "Pomo",
            "description": taskName,
            "tags": [],
            "workspace_id": 5762183,
            "duration": unixtime, //UNIX時間
            "start": start, //開始時刻("1984-06-08T11:02:53+00:00")
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: data)
        
        /// URLにアクセス
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            if let error = error {
                print("Failed to get item info: \(error)")
                return;
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            print("-----1> responseJSON: \(responseJSON)")
            if let responseJSON = responseJSON as? [String: Any] {
                print("-----2> responseJSON: \(responseJSON)")
            }
        }.resume()
    }
    
    public func stopEvent(timeEntryId: Int) {
        
        if (timeEntryId == 0) {
            return
        }
        
        let url = URL(string: "https://api.track.toggl.com/api/v9/workspaces/5762183/time_entries/" + String(timeEntryId) + "/stop")
        
        /// URLの生成
        let authData: Data = str.data(using: .utf8)!
        var request = URLRequest(url: url!)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Basic " + authData.base64EncodedString(), forHTTPHeaderField: "Authorization")
        
        /// URLにアクセス
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            if let error = error {
                print("Failed to get item info: \(error)")
                return;
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            print("-----1> responseJSON: \(responseJSON)")
            if let responseJSON = responseJSON as? [String: Any] {
                print("-----2> responseJSON: \(responseJSON)")
            }
        }.resume()
    }
}
