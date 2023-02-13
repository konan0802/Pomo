//
//  TaskSS.swift
//  Pomo Watch App
//
//  Created by 小南佑介 on 2023/02/13.
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
struct TaskSS: Decodable {
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
    }
}
