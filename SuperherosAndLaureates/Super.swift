//
//  Super.swift
//  SuperherosAndLaureates
//
//  Created by student on 4/13/19.
//  Copyright © 2019 student. All rights reserved.
//

import Foundation

struct Superhero: Codable {
    var squadName: String
    var homeTown: String
    var formed: Int
    var secretBase: String
    var active: Bool
    var members: [Members]
}

struct Members: Codable {
    var name: String
    var age: Int
    var secretIdentity: String
    var powers: [String]
}

class Superheroes {
    
    static var shared = Superheroes()
    
    var superheroesSquad: [Members]
    
    init(){
        superheroesSquad = []
    }
    
    let superheroesURL: String = "https://www.dropbox.com/s/wpz5yu54yko6e9j/squad.json?dl=1"
    
    func fetchJSONDataFromURL(){
        let urlSession = URLSession.shared
        let url = URL(string: superheroesURL)
        urlSession.dataTask(with: url!, completionHandler: displaySuperheroesData).resume()
    }
    
    func displaySuperheroesData(data:Data?, urlResponse:URLResponse?, error:Error?)->Void {
        do {
            let decoder = JSONDecoder()
            let superheroesData = try decoder.decode(Superhero.self, from: data!)
            self.superheroesSquad = superheroesData.members
            NotificationCenter.default.post(name: NSNotification.Name("Superheroes squad - delivered"), object: nil)
        }catch {
            print(error)
        }
    }
}
