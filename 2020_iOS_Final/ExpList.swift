//
//  ExpList.swift
//  2020_iOS_Final
//
//  Created by Hannn on 2020/6/23.
//  Copyright © 2020 Hannn. All rights reserved.
//

import SwiftUI

struct ExpList: View {
    @ObservedObject var expsData : ExpData
    
    @State private var showEditExp = false
    
    var body: some View {
        NavigationView {
            List{
                ForEach(expsData.Exps) { (exp) in
                    NavigationLink(destination: ExpEditor(expsData: self.expsData)) {
                        ExpRow(exp: exp)
                    }
                }
                .onDelete { (indexSet) in
                    self.expsData.Exps.remove(atOffsets: indexSet)
                }
                .onMove { (indexSet, index) in
                    self.expsData.Exps.move(fromOffsets: indexSet,
                                              toOffset: index)
                }
            }
                
            .navigationBarTitle("單字表")
            .navigationBarItems(leading: EditButton().font(.system(size:25)) , trailing: Button(action: {
                self.showEditExp = true
            }) {
                Image(systemName: "plus.circle")
                    .font(.system(size:25))
            })
                .sheet(isPresented: $showEditExp) {
                    NavigationView {
                        ExpEditor(expsData: self.expsData)
                    }
            }
        }
    }
}
