//
//  NetworkManager.swift
//  Weather
//
//  Created by Nirakar Sapkota on 8/11/20.
//  Copyright © 2020 Nirakar. All rights reserved.
//

import Foundation

class NetworkManager: ObservableObject{
    
    @Published var data = [Temperature]();
    
        // function to fetch data
        func fetchData() {
            // URL Session & Task
            if let url = URL(string: "https://api.darksky.net/forecast/d3fba72e83fc64768952cbf06ee6e5d1/38.978291,-76.495682?exclude=currently,minutely,daily,alerts,flags#") {
                let session = URLSession(configuration: .default)
                let task = session.dataTask(with: url) { (data, response, error) in
                    if error == nil {
                        //Decoding JSON
                        let decoder = JSONDecoder()
                        if let safeData = data {
                            do {
                                let results = try decoder.decode(Result.self, from: safeData)
                                DispatchQueue.main.async {
                                    self.data = results.hourly.data
                                    print("Loaded Data/Refreshed")
                                }
                            } catch {
                                print(error)
                            }
                        }
                    }
                }
                task.resume()
            }
        }
    }
        

    

