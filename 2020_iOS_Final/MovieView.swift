//
//  MovieView.swift
//  2020_iOS_Final
//
//  Created by Hannn on 2020/6/16.
//  Copyright © 2020 Hannn. All rights reserved.
//

import SwiftUI
import URLImage

struct MovieView: View {
    @ObservedObject var apiManager = APIManager.shared
    
    var body: some View {
        
        NavigationView{
            
            List{
                if(self.apiManager.movies.count > 0) {
                    ForEach(0 ..< 8) { (item) in
                        NavigationLink(destination: WebView(urlString: "https://www.youtube.com/results?search_query=\(self.apiManager.movies[item].Title.replacingOccurrences(of: " ", with: "+"))")) {
                            movieList(index: item)
                        }
                        
                    }.frame(height: 200)
                    
                }
            }
            .navigationBarTitle("Movies")
        }
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView()
    }
}

struct movieList: View {
    @ObservedObject var apiManager = APIManager.shared
    var index: Int
    
    var body: some View {
        HStack{
            VStack{
                Text(self.apiManager.movies[index].Year)
                                   .fontWeight(.bold)
                                   .font(.system(size: 20))
                                   .frame(width: 180)
                                   .padding()
                
                Text(self.apiManager.movies[index].Title)
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                    .frame(width: 180)
                    .padding()
                    .background(Color(red:91/255, green:179/255, blue:199/255))
                    .cornerRadius(40)
                    .foregroundColor(.white)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 40)
                            .stroke(Color(red:91/255, green:179/255, blue:199/255), lineWidth: 5))
            }
            
            URLImage(URL(string: self.apiManager.movies[index].Poster)!) { proxy in
                proxy.image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 200)
                    .clipped()
            }
        }
        
    }
}
