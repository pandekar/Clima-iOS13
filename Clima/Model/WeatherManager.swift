//
//  WeatherManager.swift
//  Clima
//
//  Created by Pande Adhistanaya on 10/02/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager,_ weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    var delegate: WeatherManagerDelegate?
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=01eefb1e65deb044d3ee72e3b5cd5ef3&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        
        performRequest(urlString)
    }
    
    func performRequest(_ urlString: String) {
        
        //1. create a URL
        if let url = URL(string: urlString) {
            
            //2. create a URLSession
            let urlSession = URLSession(configuration: .default)
            
            //3. give the session a task
            //5. make closure for callback <completionHandler: (Data?, URLResponse?, Error?) -> Void>
            let task = urlSession.dataTask(with: url, completionHandler: { (data, urlResponse, error) in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let resultData = data {
                    if let weather = parseJSON(resultData) {
                        delegate?.didUpdateWeather(self, weather)
                    }
                }
            })
            
            //4. start the task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let name = decodedData.name
            let weatherCode = decodedData.weather[0].id
            let temperature = decodedData.main.temp
            
            let weatherData = WeatherModel(name: name, weatherId: weatherCode, temperature: temperature)
            
            return weatherData
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
}
