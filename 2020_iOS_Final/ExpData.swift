//
//  ExpData.swift
//  2020_iOS_Final
//
//  Created by Hannn on 2020/6/23.
//  Copyright © 2020 Hannn. All rights reserved.
//


import Foundation
import Combine

class ExpData: ObservableObject {
    @Published var Exps = [Exp]()
    var cancellable: AnyCancellable?
    
    
    init() {
        
        if let data = UserDefaults.standard.data(forKey: "exps") {
            let decoder = JSONDecoder()
            if let decodedData = try? decoder.decode([Exp].self, from: data) {
                Exps = decodedData
            }
        }
        
        
        cancellable = $Exps
            .sink { (value) in
                let encoder = JSONEncoder()
                do {
                    let data = try encoder.encode(value)
                    UserDefaults.standard.set(data, forKey: "exps")
                } catch {
                    
                }
        }
        
    }
}
