//
//  SlytherinView.swift
//  2020_iOS_Final
//
//  Created by Hannn on 2020/6/21.
//  Copyright © 2020 Hannn. All rights reserved.
//

import SwiftUI
import URLImage

struct SlytherinView: View {
    @ObservedObject var apiManager = APIManager.shared
    @EnvironmentObject var charsData: APIManager
    
    var body: some View {
        NavigationView{
            List{
                ForEach(0 ..< self.apiManager.slyChars.count) { (item) in
                    NavigationLink(destination: SlytherinrowView(index: item)) {
                        SlytherincharList(index: item)
                    }
                }.frame(height: 200)
            }
                
                
            .navigationBarTitle("角色介紹")
        }
    }
}

struct SlytherincharList: View {
    @ObservedObject var apiManager = APIManager.shared
    var index: Int
    
    var body: some View {
        HStack (spacing: 30){
            URLImage(URL(string: self.apiManager.slyChars[index].image.replacingOccurrences(of: "http", with: "https"))!) { proxy in
                proxy.image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 200)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
            }
            
            Text(self.apiManager.slyChars[index].name)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(Color.black)
                .multilineTextAlignment(.center)
        }
        .frame(width: 400, height: 180)
        .background(LinearGradient(gradient: Gradient(colors: [Color(red: 172/255, green: 236/255, blue: 215/255), Color(red: 251/255, green: 238/255, blue: 152/255)]), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 1, y: 1)))
        .cornerRadius(10)
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.white, lineWidth: 3))
        
    }
}

struct SlytherinrowView: View {
    @ObservedObject var apiManager = APIManager.shared
    var index: Int
    
    @State var picshow = false
    
    var body: some View {
        
        VStack{
            if picshow{
                SlytherindetailView(index: self.index)
                    .transition(.slide)
            }
        }.animation(.easeInOut(duration:1.3))
            .onAppear {
                self.picshow = true
                
        }
        .onDisappear {
            self.picshow = false
            
        }
    }
    
}

struct SlytherindetailView: View {
    @ObservedObject var apiManager = APIManager.shared
    var index: Int
    
    var body: some View {
        VStack (spacing: 30){
            URLImage(URL(string: self.apiManager.slyChars[index].image.replacingOccurrences(of: "http", with: "https"))!) { proxy in
                proxy.image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 240, height: 320)
                    .clipped()
            }
            
            Text(self.apiManager.slyChars[index].name)
                .font(.system(size: 50))
                .fontWeight(.bold)
                .padding()
                .foregroundColor(.black)
                .background(Color.green)
                .cornerRadius(30)
            
            HStack{
                Text("Birth：")
                    .font(.system(size: 40))
                
                Text(self.apiManager.slyChars[index].dateOfBirth)
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .padding()
                    .foregroundColor(.black)
            }
            
            Rectangle()
                .frame(height: 1.0, alignment: .bottom)
                .foregroundColor(Color.gray)
            
            HStack{
                Text("Actor：")
                    .font(.system(size: 30))
                
                Text(self.apiManager.slyChars[index].actor)
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .padding()
                    .foregroundColor(.black)
            }
        }
    }
}

