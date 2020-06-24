//
//  ListView.swift
//  2020_iOS_Final
//
//  Created by Hannn on 2020/6/16.
//  Copyright © 2020 Hannn. All rights reserved.
//

import SwiftUI
import URLImage
import UIKit
import SwiftUICharts


struct ListView: View {
    @ObservedObject var apiManager = APIManager.shared
    @State private var showGryffindor = false
    @State private var showHufflepuff = false
    @State private var showRavenclaw = false
    @State private var showSlytherin = false
    @State private var showEditLover = false
    
    @State private var showChart = false
    
    var body: some View {
        
        NavigationView {
            GeometryReader { geometry in
                VStack{
                    Button(action:{
                        self.showGryffindor = true
                    }){
                        HStack {
                            URLImage(URL(string: "https://i2.kknews.cc/SIG=4ljeo5/37q300042pqsr2sq724n.jpg")!) { proxy in
                                proxy.image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 150, height: geometry.size.height/4 - 30)
                                    .clipped()
                            }
                            Text("Gryffindor")
                                .font(.system(size: 40))
                                .fontWeight(.bold)
                                .padding()
                                .foregroundColor(.black)
                                .background(Color.white)
                                .cornerRadius(50)
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height/4 - 20)
                        .background(Color.red)
                    }.sheet(isPresented: self.$showGryffindor) {
                        GryffindorView()
                    }.buttonStyle(PlainButtonStyle())
                    
                    Button(action:{
                        self.showHufflepuff = true
                    }){
                        HStack {
                            URLImage(URL(string: "https://i2.kknews.cc/SIG=42mhl0/37pr00044251247s9q2p.jpg")!) { proxy in
                                proxy.image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 150, height: geometry.size.height/4 - 30)
                                    .clipped()
                            }
                            Text("Hufflepuff")
                                .font(.system(size: 40))
                                .fontWeight(.bold)
                                .padding()
                                .foregroundColor(.black)
                                .background(Color.white)
                                .cornerRadius(50)
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height/4 - 20)
                        .background(Color.yellow)
                    }.sheet(isPresented: self.$showHufflepuff) {
                        HufflepuffView()
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Button(action:{
                        self.showRavenclaw = true
                    }){
                        HStack {
                            URLImage(URL(string: "https://i2.kknews.cc/SIG=348ipv0/37q300043212opqrn9qp.jpg")!) { proxy in
                                proxy.image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 150, height: geometry.size.height/4 - 30)
                                    .clipped()
                            }
                            Text("Ravenclaw")
                                .font(.system(size: 40))
                                .fontWeight(.bold)
                                .padding()
                                .foregroundColor(.black)
                                .background(Color.white)
                                .cornerRadius(50)
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height/4 - 20)
                        .background(Color.blue)
                    }.sheet(isPresented: self.$showRavenclaw) {
                        RavenclawView()
                    }.buttonStyle(PlainButtonStyle())
                    
                    Button(action:{
                        self.showSlytherin = true
                    }){
                        HStack {
                            URLImage(URL(string: "https://i2.kknews.cc/SIG=3fsvp7h/37q30004327806sn0907.jpg")!) { proxy in
                                proxy.image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 150, height: geometry.size.height/4 - 30)
                                    .clipped()
                            }
                            Text("Slytherin")
                                .font(.system(size: 40))
                                .fontWeight(.bold)
                                .padding()
                                .foregroundColor(.black)
                                .background(Color.white)
                                .cornerRadius(50)
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height/4 - 20)
                        .background(Color.green)
                    }.sheet(isPresented: self.$showSlytherin) {
                        SlytherinView()
                    }.buttonStyle(PlainButtonStyle())
                    
                    
                }
            }
                
            .navigationBarTitle("House", displayMode: .inline)
                
            .navigationBarItems(trailing:
                Button(action: {
                    self.showEditLover = true
                }) {
                    Image(systemName: "chart.pie.fill")
                }
                .sheet(isPresented: $showEditLover) {
                    NavigationView {
                        BarChartView(data: ChartData(values: [("Gryffindor",self.apiManager.gryChars.count.doubleValue), ("Ravenclaw",self.apiManager.ravChars.count.doubleValue), ("Slytherin",self.apiManager.slyChars.count.doubleValue), ("Hufflepuff",self.apiManager.hufChars.count.doubleValue)]), title: "BarChart", style: Styles.barChartMidnightGreenLight, form: ChartForm.extraLarge)
                            
                            
                        .navigationBarTitle("Statistics")
                    }
            })
            
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
