//
//  PhotoData.swift
//  2020_iOS_Final
//
//  Created by Hannn on 2020/6/21.
//  Copyright © 2020 Hannn. All rights reserved.
//

import Foundation

struct Photo: Identifiable, Codable {
    var id = UUID()
    var content: String
    var imageName: String
    var imagePath: String {
        return PhotoData.documentsDirectory.appendingPathComponent(imageName).path
    }
}

class PhotoData: ObservableObject {

    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    @Published var photos = [Photo]() {
        didSet {
            if let data = try? PropertyListEncoder().encode(photos) {
                let url = PhotoData.documentsDirectory.appendingPathComponent("photos")
                try? data.write(to: url)
            }
        }
    }
    
    init() {
        let url = PhotoData.documentsDirectory.appendingPathComponent("photos")
        if let data = try? Data(contentsOf: url), let array = try?  PropertyListDecoder().decode([Photo].self, from: data) {
            photos = array
        }
    }
}
