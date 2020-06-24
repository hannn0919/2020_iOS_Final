//
//  House.swift
//  2020_iOS_Final
//
//  Created by Hannn on 2020/6/12.
//  Copyright © 2020 Hannn. All rights reserved.
//

import Foundation

struct House: Codable {
    //var id = UUID()
    var name: String
    var mascot: String
    var headOfHouse: String
    var houseGhost: String
    var founder: String
    var school: String?
    var members: [String]
    var values: [String]
    var colors: [String]
}
