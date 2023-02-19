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
                    parseJSON(weatherData: resultData)
                }
            })
            
            //4. start the task
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
//            print(decodedData.name, decodedData.main.temp, decodedData.weather[0].id)
            let weatherCode = decodedData.weather[0].id
            let weatherCondition = getCondition(weatherCode: weatherCode)
            print(weatherCondition)
        } catch {
            print("error >>>", error)
        }
    }
    
    func getCondition(weatherCode: Int) -> String {
        switch weatherCode {
        case 200...232:
            return "cloud.bolt.rain.fill"
        case 300...321:
            return "cloud.drizzle.fill"
        case 500...531:
            return "cloud.rain.fill"
        case 600...622:
            return "cloud.snow.fill"
        case 701:
            return "smoke"
        case 711:
            return "Smoke.fill"
        case 721:
            return "cloud.fog"
        case 731:
            return "sun.dust.fill"
        case 741:
            return "cloud.fog.fill"
        case 751:
            return "sun.dust"
        case 761:
            return "sun.dust.fill"
        case 762:
            return "mountain.2.circle.fill"
        case 771:
            return "cloud.bolt"
        case 781:
            return "tropicalstorm.circle"
        case 801...804:
            return "cloud"
        default:
            return "sun.max"
        }
    }
}
