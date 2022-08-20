//
//  WeatherData.swift
//  Weather
//
//  Created by Mihai Gorgan on 10.08.2022.
//

import Foundation

struct WeatherData: Decodable {
    let list: [wtList]
    let city: City
}

struct wtList: Decodable{
    let main: Main
    let weather: [Weather]
    let dt_txt: String
}

struct City: Decodable{
    let name: String
}

struct Main: Decodable{
    let temp: Double
}

struct Weather: Decodable{
    let id: Int
}

struct WeatherModel: Decodable {
    let time: String
    let weekDay: String
    let image: String
    let temp: String
}



//struct WeatherDdata: Decodable {
//    let name: String
//    let main: Main
//    let weather: [Weather]
//}

