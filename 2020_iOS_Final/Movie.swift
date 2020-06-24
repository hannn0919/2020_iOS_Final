//
//  Movie.swift
//  2020_iOS_Final
//
//  Created by Hannn on 2020/6/19.
//  Copyright © 2020 Hannn. All rights reserved.
//

import Foundation

struct Movie: Codable {
    var Search: [EP]
    
    struct EP: Codable {
        var Title: String
        var Year: String
        var imdbID: String
        var Poster: String
    }
}
