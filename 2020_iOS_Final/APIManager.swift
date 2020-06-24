//
//  APIManager.swift
//  2020_iOS_Final
//
//  Created by Hannn on 2020/6/12.
//  Copyright © 2020 Hannn. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import Alamofire

class APIManager: ObservableObject {
    
    static let shared = APIManager()
    
    @Published var characters = [Character]()
    @Published var slyChars = [Character]()
    @Published var gryChars = [Character]()
    @Published var ravChars = [Character]()
    @Published var hufChars = [Character]()
    
    @Published var houses = [House]()
    @Published var spells = [Spell]()
    @Published var hat = String()
    @Published var movies = [Movie.EP]()
    
    var cancellable: AnyCancellable?
    
    
    struct API {
        static let getCharacters = "https://hp-api.herokuapp.com/api/characters"
        static let getslyChars = "https://hp-api.herokuapp.com/api/characters/house/slytherin"
        static let getgryChars = "https://hp-api.herokuapp.com/api/characters/house/gryffindor"
        static let getravChars = "https://hp-api.herokuapp.com/api/characters/house/ravenclaw"
        static let gethufChars = "https://hp-api.herokuapp.com/api/characters/house/hufflepuff"
        
        static let getHouses = "https://www.potterapi.com/v1/houses?key=$2a$10$mxlxMicjkCnYIXpQ/j5HQeAxt53JvciVvO4KxKimPGNeLBzJ88dVS"
        static let getSpells = "https://www.potterapi.com/v1/spells?key=$2a$10$mxlxMicjkCnYIXpQ/j5HQeAxt53JvciVvO4KxKimPGNeLBzJ88dVS"
        static let sortingHat = "https://www.potterapi.com/v1/sortingHat"
        static let OMDB = "https://www.omdbapi.com/?apikey=ed3d67e3&type=movie&s=harry+potter"
    }
    
    init() {
        getCharactersList()
        getHousesList()
        getSpellsList()
        getMovieList()
        getgryCharsList()
        gethufCharsList()
        getravCharsList()
        getslyCharsList()
        
        /*
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        let url = documentsDirectory.appendingPathComponent("starChar")
        
        if let data = try? Data(contentsOf: url) {
            let decoder = JSONDecoder()
            if let decodedData = try? decoder.decode([Character].self, from: data) {
                characters = decodedData
            }
        }
        
        cancellable = $characters
            .sink { (value) in
                let encoder = JSONEncoder()
                do {
                    let data = try encoder.encode(value)
                    try? data.write(to: url)
                } catch {
                    
                }
        }
        */
    }
    
    func getMovieList() {
        guard let url = URL(string: API.OMDB) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            let response = try! JSONDecoder().decode(Movie.self, from: data)
            DispatchQueue.main.async {
                self.movies = response.Search
            }
            print("movies values fetched Successfully")
        }.resume()
    }
    
    func getCharactersList() {
        guard let url = URL(string: API.getCharacters) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            let response = try! JSONDecoder().decode([Character].self, from: data)
            DispatchQueue.main.async {
                self.characters = response
            }
            print("characters values fetched Successfully")
        }.resume()
    }
    
    func gethufCharsList() {
        guard let url = URL(string: API.gethufChars) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            let response = try! JSONDecoder().decode([Character].self, from: data)
            DispatchQueue.main.async {
                self.hufChars = response
            }
            print("hufChars values fetched Successfully")
        }.resume()
    }
    
    func getslyCharsList() {
        guard let url = URL(string: API.getslyChars) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            let response = try! JSONDecoder().decode([Character].self, from: data)
            DispatchQueue.main.async {
                self.slyChars = response
            }
            print("slyChars values fetched Successfully")
        }.resume()
    }
    
    func getgryCharsList() {
        guard let url = URL(string: API.getgryChars) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            let response = try! JSONDecoder().decode([Character].self, from: data)
            DispatchQueue.main.async {
                self.gryChars = response
            }
            print("gryChars values fetched Successfully")
        }.resume()
    }
    
    func getravCharsList() {
        guard let url = URL(string: API.getravChars) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            let response = try! JSONDecoder().decode([Character].self, from: data)
            DispatchQueue.main.async {
                self.ravChars = response
            }
            print("ravChars values fetched Successfully")
        }.resume()
    }
    
    func getHousesList() {
        guard let url = URL(string: API.getHouses) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            let response = try! JSONDecoder().decode([House].self, from: data)
            DispatchQueue.main.async {
                self.houses = response
            }
            print("houses values fetched Successfully")
        }.resume()
    }
    
    func getSpellsList() {
        guard let url = URL(string: API.getSpells) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            let response = try! JSONDecoder().decode([Spell].self, from: data)
            DispatchQueue.main.async {
                self.spells = response
            }
            print("spells values fetched Successfully")
        }.resume()
    }
    
    func getSortingHat() {
        guard let url = URL(string: API.sortingHat) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            let response = try! JSONDecoder().decode(String.self, from: data)
            DispatchQueue.main.async {
                self.hat = response
            }
            print("sortingHat values fetched Successfully")
        }.resume()
    }
    
    func uploadImage(uiImage: UIImage, completion:@escaping((Result<String, NetworkError>) -> Void)){
        let headers: HTTPHeaders = [
            "Authorization": "Client-ID 205ca25da75b199",
        ]
        AF.upload(multipartFormData: { (data) in
            let imageData = uiImage.jpegData(compressionQuality: 0.8)
            data.append(imageData!, withName: "image")
        }, to: "https://api.imgur.com/3/upload", headers: headers).responseDecodable(of: UploadImageResult.self, queue: .main, decoder: JSONDecoder()){(response) in
            switch response.result {
            case .success(let result):
                completion(.success(result.data.link))
                print(result.data.link)
            case .failure(let error):
                completion(.failure(NetworkError.Error))
                print(error)
            }
        }
    }
    
}
