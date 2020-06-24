//
//  InfoView.swift
//  2020_iOS_Final
//
//  Created by Hannn on 2020/6/16.
//  Copyright © 2020 Hannn. All rights reserved.
//

import SwiftUI
import SwiftUICharts
import URLImage
import CoreData

let userDefaults = UserDefaults.standard
var rowHeight: CGFloat = 50

struct InfoView: View {
    @ObservedObject var apiManager = APIManager.shared
    @ObservedObject var expsData : ExpData
    
    @State private var showEditExp = false
    @State private var selectImage: UIImage?
    @State private var showImageSelect = false
    @State private var showAlert = false
    @State private var showAlert2 = false
    @State private var locationPhoto = false
    @State private var opacity: Double = 0.87
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: ExpItems.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \ExpItems.title, ascending: false)])
    
    var fetchedItems: FetchedResults<ExpItems>
    
    var body: some View {
        NavigationView{
            VStack{
                if userDefaults.string(forKey: "thePhotoPath") != nil && self.locationPhoto == false {
                    URLImage(URL(string: userDefaults.string(forKey: "thePhotoPath")!)!){ proxy in
                        proxy.image
                            .resizable()
                            .scaledToFill()
                            .frame(width:250, height: 250)
                            .cornerRadius(30)
                            .shadow(radius: 50)
                            .opacity(self.opacity)
                    }
                }
                else if self.locationPhoto == true && self.selectImage != nil{
                    Image(uiImage: self.selectImage!)
                        .resizable()
                        .scaledToFill()
                        .frame(width:250, height: 250)
                        .cornerRadius(30)
                        .shadow(radius: 50)
                        .opacity(self.opacity)
                }
                
                Slider(value:$opacity,in: 0...1)
                
                HStack{
                    Button(action:{
                        self.showImageSelect = true
                        self.locationPhoto = true
                    }){
                        Text("change photo")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .padding()
                            .foregroundColor(.black)
                            .background(Color.gray)
                            .cornerRadius(30)
                    }.sheet(isPresented: self.$showImageSelect){
                        ImagePickerController(selectImage: self.$selectImage, showSelectPhoto: self.$showImageSelect)
                    }
                    
                    Spacer()
                    
                    Button(action:{
                        if self.selectImage != nil {
                            APIManager.shared.uploadImage(uiImage: self.selectImage!){
                                (result) in
                                switch result{
                                case .success(let link):
                                    userDefaults.set(link, forKey:"thePhotoPath")
                                    print("userDf: " + userDefaults.string(forKey: "thePhotoPath")!)
                                case .failure( _):
                                    print("upLoad Image Error.")
                                }
                            }
                        }else{
                            self.showAlert = true
                        }
                    }){
                        Text("save")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .padding()
                            .foregroundColor(.black)
                            .background(Color.gray)
                            .cornerRadius(30)
                    }
                }
                
                List {
                    ForEach(fetchedItems, id: \.self) { item in
                        HStack {
                            VStack(alignment: .leading){
                                HStack{
                                    Text(item.title ?? "Empty")
                                        .foregroundColor(.red)
                                        .font(.system(size: 20))
                                        .fontWeight(.bold)
                                    Spacer()
                                    Spacer()
                                    Spacer()
                                    Spacer()
                                    Text("\(item.score) / 5")
                                    Spacer()
                                }
                                Text(item.des ?? "none")
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            if(item.star) {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                            }
                            else {
                                Image(systemName: "star")
                            }
                        }
                        
                    }
                    .onDelete(perform: removeItems)
                    .frame(height: rowHeight)
                    
                }
                
            }
            .navigationBarTitle("Setting", displayMode: .inline)
            .navigationBarItems(leading: EditButton() , trailing: Button(action: {
                self.showEditExp = true
            }) {
                Image(systemName: "plus.circle.fill")
            })
                .sheet(isPresented: $showEditExp) {
                    NavigationView {
                        ExpEditor(expsData: self.expsData).environment(\.managedObjectContext, self.managedObjectContext)
                    }
            }
        }
    }
    
    func saveExp(title: String, des: String, score: Int, star: Bool) {
        let newToDoItem = ExpItems(context: self.managedObjectContext)
        newToDoItem.title = title
        newToDoItem.des = des
        newToDoItem.star = star
        do {
            try self.managedObjectContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func markExpStar(at index: Int) {
        let item = fetchedItems[index]
        item.star = true
        do {
            try self.managedObjectContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        for index in offsets {
            let item = fetchedItems[index]
            managedObjectContext.delete(item)
        }
        do {
            try managedObjectContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension Int {
    var doubleValue: Double {
        return Double(self)
    }
}
