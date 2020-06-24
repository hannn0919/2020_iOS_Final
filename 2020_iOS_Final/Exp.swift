//
//  Exp.swift
//  2020_iOS_Final
//
//  Created by Hannn on 2020/6/23.
//  Copyright © 2020 Hannn. All rights reserved.
//

import Foundation

struct Exp: Identifiable, Codable {
    var id = UUID()
    var title: String
    var date: Date
    var des: String
    var score: Int
    var isStar: Bool
}
