//
//  ExpRow.swift
//  2020_iOS_Final
//
//  Created by Hannn on 2020/6/23.
//  Copyright © 2020 Hannn. All rights reserved.
//

import SwiftUI

struct ExpRow: View {
    var exp: Exp
    var body: some View {
        HStack {
            Text(exp.title)
            Spacer()
            Image(systemName: exp.isStar ? "heart.fill" : "heart")
        }.padding(.horizontal)
    }
}
