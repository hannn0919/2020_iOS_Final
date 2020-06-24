//
//  InteractiveView.swift
//  2020_iOS_Final
//
//  Created by Hannn on 2020/6/16.
//  Copyright © 2020 Hannn. All rights reserved.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct InteractiveView: View {
    @ObservedObject var apiManager = APIManager.shared
    @State private var ranChar = 0
    @State private var ranSpell = 0
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        ZStack{
            ShakableViewRepresentable()
                .allowsHitTesting(false)
            
            VStack{
                Spacer()
                Text("Click hat or Shake it!")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .padding()
                
                Spacer()
                Button(action:{
                    self.shakePhone()
                }){
                    Image("sortingHat")
                        .overlay(Circle().stroke(Color.black, lineWidth: 6))
                        .shadow(radius: 10)
                }.buttonStyle(PlainButtonStyle())
                Spacer()
                Text("\(self.apiManager.hat)")
                    .font(.system(size: 60))
                    .fontWeight(.bold)
                    .padding()
                    .foregroundColor(.black)
                    .background(Color.white)
                    .cornerRadius(50)
                    .onReceive(messagePublisher) { _ in
                        self.shakePhone()
                }
                Spacer()
                
                Image(uiImage: generateQRCode(from: "\(self.apiManager.hat)"))
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    
                Spacer()
            }
        }.background(setBackground(house: "\(self.apiManager.hat)"))
    }
    
    func shakePhone() {
        self.apiManager.getSortingHat()
    }
    
    func generateQRCode(from string: String) -> UIImage {
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")
        
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
}

struct InteractiveView_Previews: PreviewProvider {
    static var previews: some View {
        InteractiveView()
    }
}


struct setBackground: View {
    var house: String
    
    var body: some View {
        if(house == "Gryffindor") {
            return Color.red
        }
        else if(house == "Ravenclaw") {
            return Color.blue
        }
        else if(house == "Slytherin") {
            return Color.green
        }
        else if(house == "Hufflepuff") {
            return Color.yellow
        }
        else {
            return Color.gray
        }
    }
}
