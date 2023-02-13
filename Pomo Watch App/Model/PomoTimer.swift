//
//  PomoTimer.swift
//  Pomo Watch App
//
//  Created by 小南佑介 on 2023/02/13.
//

import Foundation

struct PomoTimer: Decodable {
    var name: String
    var duration: Int
    var limit: Int
    var color: CororRGB
}
