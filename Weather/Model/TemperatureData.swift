//
//  TemperatureData.swift
//  Weather
//
//  Created by Nirakar Sapkota on 8/11/20.
//  Copyright © 2020 Nirakar. All rights reserved.
//

import Foundation

struct Result: Decodable{
    let hourly: Hourly
}

struct Hourly: Decodable{
    let data: [Temperature]
}


struct Temperature: Decodable, Identifiable{
    var id: Int {
        return time //Since Identifiable by timestamp
    }
    let time: Int
    let temperature: Double
}
