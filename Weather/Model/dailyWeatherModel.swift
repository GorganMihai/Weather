//
//  WeatherModel.swift
//  Weather
//
//  Created by Mihai Gorgan on 10.08.2022.
//

import Foundation

struct dailyWeatherModel {
    
    var conditionName: String
    var cityName: String
    var temperatureString: String
    var dailyWeatherModel: [WeatherModel]?
            
    init (condition: Int, cityName: String, temperature: Double, dailyList: [wtList]) {
        
        var dateIndex: Date = initDate()
        
        self.conditionName = iconString(condition)
        self.cityName = cityName
        self.temperatureString = String(format: "%.1f", temperature)
        
        //Init primul element
        
        self.dailyWeatherModel = dailyListFilter(dailyList)
               
        
        func dailyListFilter(_ dlList: [wtList]) -> [WeatherModel]{
            var result = [WeatherModel]()
            
            
            result.append(WeatherModel(time: shortStringDate(dateFromString(dlList[0].dt_txt)),
                                                   weekDay: "Today",
                                                   image: iconString(dlList[0].weather[0].id),
                                                   temp: "\(String(format: "%.1f", dlList[0].main.temp))°"))
            
            for item in dlList {
                
                let auxDate: Date = dateFromString(item.dt_txt)
                                   
                if auxDate > dateIndex {
                
                    result.append(WeatherModel(time: shortStringDate(auxDate),
                                                           weekDay: weekDayString(auxDate),
                                                           image: iconString(item.weather[0].id),
                                                           temp: "\(String(format: "%.1f", item.main.temp))°"))
                    dateIndex = auxDate
                }
                  
            }
            
            return result
            
        }
        
        
        
        func dateFromString(_ stringDate: String) -> Date {
            
            let shortDate = String(String(stringDate).dropLast(9))
            
            let inFormatter = DateFormatter()
            inFormatter.dateFormat = "yyyy-MM-dd"
            
            let result: Date = inFormatter.date(from: shortDate)!
            
            return result
        }

        func initDate() -> Date {
            let currentDate: Date = Date.now
            
            let inFormatter = DateFormatter()
            inFormatter.dateFormat = "MMM d, h:mm a"
            
            let outFormatter = DateFormatter()
            outFormatter.dateFormat = "yyyy-MM-dd"
            
            let stringdate: String = outFormatter.string(from: currentDate)
            
            return outFormatter.date(from: stringdate)!
                
        }
        
        func shortStringDate(_ date: Date) -> String {
            
            let outFormatter = DateFormatter()
            outFormatter.dateFormat = "MM/dd"
            
            return outFormatter.string(from: date)
        }

        func weekDayString(_ date: Date) -> String {
            
            let outFormatter = DateFormatter()
            outFormatter.dateFormat = "E"
            
            return outFormatter.string(from: date)
        }
        
        func iconString(_ conditionCode: Int) -> String {
            
            switch conditionCode {
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
        }}
    }
    
    
    
    
    
    
    
    
}
