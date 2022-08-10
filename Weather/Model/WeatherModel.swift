//
//  WeatherModel.swift
//  Weather
//
//  Created by Mihai Gorgan on 10.08.2022.
//

import Foundation

struct WeatherModel {
    let condition: Int
    let cityName: String
    let temperature: Double
    
    var conditionName: String {
        
        switch condition {
            case 200...234:
                return "cloud.bolt.rain"
            case 300...321:
                return "cloud.drizzle.fill"
            case 500...531:
                return "cloud.heavyrain.fill"
            case 600...622:
                return "cloud.snow.fill"
            case 700...781:
                return "aqi.high"
            case 800:
                return "sun.max.fill"
            case 801...804:
                return "cloud.fill"
            default:
                return "xmark.octagon"
            
        }
        
    }
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    
}
