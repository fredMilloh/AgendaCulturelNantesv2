//
//  QueryService.swift
//  AgendaCulturelNantesv2
//
//  Created by fred on 15/07/2020.
//  Copyright © 2020 fred. All rights reserved.
//

import Foundation

class QueryService {

    static var shared = QueryService()
    private init() {}

    

    func get(dateSelected: String, callback: @escaping(Result<ModelEvents, EventsError>) -> Void) {
       
        let firstUrl = "https://data.nantesmetropole.fr/api/records/1.0/search/?dataset=244400404_agenda-evenements-nantes-nantes-metropole&rows=50&q="
        let pathName = String(firstUrl + "\""+dateSelected+"\"")
        let Url = pathName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: Url)!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
                DispatchQueue.main.async {

                    guard let data = data, error == nil else {
                        callback(.failure(.missingData))
                        return
                        }
                    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        callback(.failure(.missingData))
                        return
                        }
                    do {
                        let result = try JSONDecoder().decode(ModelEvents.self, from: data)
                        callback(.success(result))
            
                    } catch {
                        callback(.failure(.cannotProcessData))
                    }
                }
            } .resume()
        }

}

