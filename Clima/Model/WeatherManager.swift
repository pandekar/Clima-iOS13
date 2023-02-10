//
//  WeatherManager.swift
//  Clima
//
//  Created by Pande Adhistanaya on 10/02/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=01eefb1e65deb044d3ee72e3b5cd5ef3&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        print(urlString)
    }
}
