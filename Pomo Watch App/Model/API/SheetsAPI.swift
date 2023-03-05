//
//  SheetsAPI.swift
//  Pomo Watch App
//
//  Created by 小南佑介 on 2023/02/19.
//

import Foundation

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
        let url = URL(string: "https://sheets.googleapis.com/v4/spreadsheets/****/values/TODAY!B3:B9?key=AIzaSyCWi_mq2gzyHb3v9WckHuJ6J6kYebDLloE&majorDimension=COLUMNS")
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
