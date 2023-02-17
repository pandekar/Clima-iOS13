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
        
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        
        //1. create a URL
        if let url = URL(string: urlString) {
            
            //2. create a URLSession
            let urlSession = URLSession(configuration: .default)
            
            //3. give the session a task
            //5. make closure for callback <completionHandler: (Data?, URLResponse?, Error?) -> Void>
            let task = urlSession.dataTask(with: url, completionHandler: { (data, urlResponse, error) in
                if error != nil {
                    print(error!)
                }
                
                if let resultData = data {
                    let dataString = String(data: resultData, encoding: .utf8)
                    print(dataString!)
                }
            })
            
            //4. start the task
            task.resume()
        }
    }
}
