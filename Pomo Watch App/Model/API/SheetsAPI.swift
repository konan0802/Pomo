//
//  SheetsAPI.swift
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
struct SheetsApiResponse: Decodable {
    var range: String
    var majorDimension: String
    var values: Array<Array<String>>
    
    enum CodingKeys: String, CodingKey {
        case range = "range"
        case majorDimension = "majorDimension"
        case values = "values"
    }
}

class SheetsAPI {
    
    public func fetchTodayTasks(conv:@escaping (SheetsApiResponse)->Void) {

        var task = SheetsApiResponse(range: "", majorDimension: "", values: [[""]])
        
        /// URLの生成
        let url = URL(string: "https://sheets.googleapis.com/v4/spreadsheets/1FatE2uTem9bY81dk1kag-R87sJcNk_g4woDthrzQ_uE/values/TODAY!B2:B9?key=AIzaSyCWi_mq2gzyHb3v9WckHuJ6J6kYebDLloE&majorDimension=COLUMNS")
        let request = URLRequest(url: url!)
        
        /// URLにアクセス
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            let data = data!
            let decoder = JSONDecoder()
            guard let decodedResponse = try? decoder.decode(SheetsApiResponse.self, from: data) else {
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
}
