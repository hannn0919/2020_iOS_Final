//
//  ContentView.swift
//  2020_iOS_Final
//
//  Created by Hannn on 2020/6/6.
//  Copyright © 2020 Hannn. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var apiManager = APIManager.shared
    @ObservedObject var expsData = ExpData()
    
    var body: some View {
        TabView {
            InteractiveView()
                .tabItem {
                    Image(systemName: "gamecontroller.fill")
                    Text("Play!")
            }
            ListView()
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("Characters")
            }
            MovieView()
                .tabItem {
                    Image(systemName: "film.fill")
                    Text("Movies")
            }
            InfoView(expsData: expsData)
                .tabItem {
                    Image(systemName: "wrench.fill")
                    Text("Setting")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
