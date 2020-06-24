//
//  struct.swift
//  2020_iOS_Final
//
//  Created by Hannn on 2020/6/21.
//  Copyright © 2020 Hannn. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case Error
}

struct UploadImageResult: Decodable {
    struct UIRData: Decodable {
        let link: String
    }
    let data: UIRData
}
