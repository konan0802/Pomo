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

struct TogglEventResponse: Decodable {
    var id: UInt32
    var duration: Int
    var description: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case duration = "duration"
        case description = "description"
    }
}

class TogglAPI {
    
    private let url = URL(string: "https://api.track.toggl.com/api/v9/me/time_entries/current")!
    private let token = "****:api_token"
    
    public func fetchCurrentEvent() async throws -> TogglEventResponse {
        
        let url = URL(string: "https://api.track.toggl.com/api/v9/me/time_entries/current")

        /// URLの生成4
        let tokenData: Data = token.data(using: .utf8)!
        var request = URLRequest(url: url!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Basic " + tokenData.base64EncodedString(), forHTTPHeaderField: "Authorization")
        
        do {
            let (data, urlResponse) = try await URLSession.shared.data(for: request, delegate: nil)
            guard let httpStatus = urlResponse as? HTTPURLResponse else {
                print(String(data: data, encoding: .utf8)!)
                print(urlResponse)
                return TogglEventResponse(id: 0, duration: 0, description: "---")
            }
            switch httpStatus.statusCode {
                case 200 ..< 400:
                    let decodedResponse = try JSONDecoder().decode(TogglEventResponse.self, from: data)
                    return decodedResponse
                default:
                    print(String(data: data, encoding: .utf8)!)
                    print(urlResponse)
                    return TogglEventResponse(id: 0, duration: 0, description: "---")
            }
        } catch {
            print(error)
            return TogglEventResponse(id: 0, duration: 0, description: "---")
        }
    }
    
    public func startEvent(taskName: String) async {
        
        let url = URL(string: "https://api.track.toggl.com/api/v9/workspaces/5762183/time_entries")
        
        /// URLの生成
        let authData: Data = token.data(using: .utf8)!
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

        do {
            let (data, urlResponse) = try await URLSession.shared.data(for: request, delegate: nil)
            guard let httpStatus = urlResponse as? HTTPURLResponse else {
                print(String(data: data, encoding: .utf8)!)
                print(urlResponse)
                return
            }
            switch httpStatus.statusCode {
                case 200 ..< 400:
                    return
                default:
                    print(String(data: data, encoding: .utf8)!)
                    print(urlResponse)
            }
        } catch {
            print(error)
        }
    }
    
    public func stopEvent(timeEntryId: UInt32) async {
        
        if (timeEntryId == 0) {
            return
        }
        
        let url = URL(string: "https://api.track.toggl.com/api/v9/workspaces/5762183/time_entries/" + String(timeEntryId) + "/stop")
        
        /// URLの生成
        let authData: Data = token.data(using: .utf8)!
        var request = URLRequest(url: url!)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Basic " + authData.base64EncodedString(), forHTTPHeaderField: "Authorization")
        /// URLにアクセス
        do {
            let (data, urlResponse) = try await URLSession.shared.data(for: request, delegate: nil)
            guard let httpStatus = urlResponse as? HTTPURLResponse else {
                print(String(data: data, encoding: .utf8)!)
                print(urlResponse)
                return
            }
            switch httpStatus.statusCode {
                case 200 ..< 400:
                    return
                default:
                    print(String(data: data, encoding: .utf8)!)
                    print(urlResponse)
            }
        } catch {
            print(error)
        }
    }
}

