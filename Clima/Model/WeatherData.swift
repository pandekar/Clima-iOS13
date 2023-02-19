//
//  WeatherData.swift
//  Clima
//
//  Created by Pande Adhistanaya on 19/02/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let weather: Array<Weather>
    let main: MainDataTemp
}

struct MainDataTemp: Decodable {
    let temp: Float
    let pressure: Int
    let humidity: Int
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}


