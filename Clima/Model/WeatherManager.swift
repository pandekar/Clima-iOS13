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
            //5. resolve completionHandler
            let task = urlSession.dataTask(with: url, completionHandler: handler(_:_:_:))
            
            //4. start the task
            task.resume()
        }
    }
    
    //6. make callback function for completionHandler
    func handler(_ data: Data?, _ urlResponse: URLResponse?, _ error: Error?) {
        
        //7. check if there is error
        if (error != nil) {
            print(error!)
            //exit function, do not continue
            return
        }
        
        //8. process acquired data
        if let resultData = data {
            
            //9. convert type Data to String
            let dataString = String(data: resultData, encoding: .utf8)
            print(dataString)
        }
        
    }
}
