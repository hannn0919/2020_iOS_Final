//
//  ExpEditor.swift
//  2020_iOS_Final
//
//  Created by Hannn on 2020/6/23.
//  Copyright © 2020 Hannn. All rights reserved.
//

import SwiftUI

struct ExpEditor: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var apiManager = APIManager.shared
    var expsData: ExpData
    @State private var title = ""
    @State private var des = ""
    @State private var date = Date()
    @State private var score = 0
    @State private var isStar = false
    @State private var showAlert = false
    var editExp: Exp?
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        return dateFormatter
    }()
    
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: ExpItems.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \ExpItems.title, ascending: false)])
    
    var fetchedItems: FetchedResults<ExpItems>
    
    
    var body: some View {
        
        Form {
            TextField("Title", text: $title)
            DatePicker("Date", selection: $date, in: ...Date(), displayedComponents: .date)
            MultilineTextField(text: $des)
            
            Stepper("Score(0~5) : \(score)", value: $score, in: 0...5)
            Toggle("Star", isOn: $isStar)
        }
        .navigationBarTitle("Add Item", displayMode: .inline)
        .navigationBarItems(trailing: Button("Save") {
            
            if(self.title == "" || self.score == 0 || self.des == "") {
                self.showAlert = true
            }
            else {
                
                let exp = Exp(title: self.title, date: self.date, des: self.des, score: self.score, isStar: self.isStar)
                
                if let editExp = self.editExp {
                    let index = self.expsData.Exps.firstIndex {
                        $0.id == editExp.id
                        }!
                    self.expsData.Exps[index] = exp
                    self.saveExp(title: self.title, des: self.des, score: self.score, star: self.isStar)
                } else {
                    self.expsData.Exps.insert(exp, at: 0)
                    self.saveExp(title: self.title, des: self.des, score: self.score, star: self.isStar)
                }
            }
            
            
            self.presentationMode.wrappedValue.dismiss()
        }.alert(isPresented: $showAlert) {
            () -> Alert in
            return Alert(title: Text("無法儲存"), message: Text("資料尚未填寫完畢"))
        })
            .onAppear {
                
                if let editExp = self.editExp {
                    self.title = editExp.title
                    self.des = editExp.des
                    self.date = editExp.date
                    self.score = editExp.score
                    self.isStar = editExp.isStar
                }
        }
        
    }
    
    func saveExp(title: String, des: String, score: Int, star: Bool) {
        let newToDoItem = ExpItems(context: self.managedObjectContext)
        newToDoItem.title = title
        newToDoItem.des = des
        newToDoItem.star = star
        newToDoItem.score = Int16(score)
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
