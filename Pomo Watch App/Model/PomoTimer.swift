//
//  PomoTimer.swift
//  Pomo Watch App
//
//  Created by 小南佑介 on 2023/02/13.
//

import Foundation

struct CororRGB: Decodable {
    var r: Double
    var g: Double
    var b: Double
}

struct PomoTimer: Decodable {
    var duration: Int
    var limit: Int
    var color: CororRGB
}
