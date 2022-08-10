//
//  ViewController.swift
//  Weather
//
//  Created by Mihai Gorgan on 09.08.2022.
//

import UIKit
import CoreLocation


class WeatherViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    
    var weatherManager = WeatherManager()
    var locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self

        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
                
        
        weatherManager.delegate = self
        searchTextField.delegate = self
    }
    
    @IBAction func locationButtonTouch(_ sender: UIButton) {
    
        locationManager.requestLocation()
    }
    
    
}




//MARK: - UITextFieldDelegate
extension WeatherViewController: UITextFieldDelegate{
    
    @IBAction func serchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
                
        print(textField)
        searchTextField.endEditing(true)
        return true
    }
    
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
                
        if textField.text != "" {
            return true
        }else{
            textField.placeholder = "Type something"
            return false
        }
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = textField.text   {
            weatherManager.fetchWeather(city)
        }
        
        searchTextField.text = ""
    }
}


//MARK: - WeatherManager

extension WeatherViewController: WeatherManagerDelegate {
    
    func didUpdateWeather (_ weatherManager: WeatherManager, weather: WeatherModel){
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.cityLabel.text = weather.cityName
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        }
}}

//MARK: - Location

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fechWeather(lat, lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    
    
    
}
