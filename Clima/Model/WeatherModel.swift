//
//  WeatherModel.swift
//  Clima
//
//  Created by Pande Adhistanaya on 19/02/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let name: String
    let weatherId: Int
    let temperature: Float
    
    // computed property
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    var weatherCondition: String {
        switch weatherId {
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
