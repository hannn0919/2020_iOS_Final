//
//  Character.swift
//  2020_iOS_Final
//
//  Created by Hannn on 2020/6/12.
//  Copyright © 2020 Hannn. All rights reserved.
//

import Foundation

struct Character: Codable {
    var name: String
    var species: String
    var gender: String
    var house: String
    var dateOfBirth: String
    var ancestry: String
    var eyeColour: String
    var hairColour: String
    var patronus: String
    var hogwartsStudent: Bool
    var hogwartsStaff: Bool
    var actor: String
    var alive: Bool
    var image: String
}
