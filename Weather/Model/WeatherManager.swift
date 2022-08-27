//
//  WeatherManager.swift
//  Weather
//
//  Created by Mihai Gorgan on 10.08.2022.
//

import Foundation
import UIKit

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: dailyWeatherModel)
}

func getApiKey () -> String? {
    
   guard let filePath = Bundle.main.path(forResource: "secret", ofType: "plist") else {
       print("File not found")
       return nil
   }
    
    let plist = NSDictionary(contentsOfFile: filePath)
    let result = plist?.object(forKey: "ClientKey") as! String
    return result
    
    
}


struct WeatherManager {
          
    let ApiKey: String? = getApiKey()
    
    //
    //let yourApiKey: String? = ......
    //
            
    func fetchWeather(_ cityName: String) -> Bool{
        
        if (ApiKey != nil) {
            let urlSting = "https://api.openweathermap.org/data/2.5/forecast?q=\(cityName)&appid=\(ApiKey!)&units=metric"
            performMainRequest(urlString: urlSting)
            return true
        }else{
            print("Plese insert your API key from openweathermap.org")
            return false
        }
    }
    
    func fechWeather(_ lat: Double, _ lon: Double) -> Bool{
        
        if (ApiKey != nil) {
            let urlSting = "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=\(ApiKey!)&units=metric"
            performMainRequest(urlString: urlSting)
            return true
        }else{
            print("Plese insert your API key from openweathermap.org")
            return false
        }
    }
        
    var delegate: WeatherManagerDelegate?
    
    func performMainRequest(urlString: String){
        //1. Create a URL
        print("Performe Request")
        //Verific daca instanta a fost creata corespunzator
        if let url = URL(string: urlString){
            
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            
            //3. Give the session a task
            let task = session.dataTask(with: url, completionHandler:
            {(data: Data?, response: URLResponse?, error: Error?) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data{
                    
                    if let weather = parseJson(weatherData: safeData){
                        delegate?.didUpdateWeather(self, weather: weather)
                    }
                }})
            
            //4. Start the task
            task.resume()
           print("End request")
        }else{
            print("URL instance error")
        }
    }
    
    func parseJson(weatherData: Data) -> dailyWeatherModel? {
        let decoder = JSONDecoder()
        do{
            let dcData = try decoder.decode(WeatherData.self, from: weatherData)
            
            let cityName = dcData.city.name
            let temp = dcData.list[0].main.temp
            let idWeatherIcon = dcData.list[0].weather[0].id
            let dailyWeather: [wtList] = dcData.list            
                        
            let weather = dailyWeatherModel(condition: idWeatherIcon, cityName: cityName, temperature: temp, dailyList: dailyWeather)

            return weather
            
                        
        }catch{
            print(error)
            return nil
        }
        
        
    }
    
    
    
    
}
