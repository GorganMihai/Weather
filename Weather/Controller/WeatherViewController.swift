//
//  ViewController.swift
//  Weather
//
//  Created by Mihai Gorgan on 09.08.2022.
//

import UIKit
import CoreLocation


class WeatherViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as! CollectionTableViewCell
        
        cell.configure(whith: models)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 148
    }
    
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet var table: UITableView!
    
    
    
    
    var models = [Model]()
    var weatherManager = WeatherManager()
    var locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.register(CollectionTableViewCell.nib(), forCellReuseIdentifier: CollectionTableViewCell.identifier)
        table.delegate = self
        table.dataSource = self
        
        
        locationManager.delegate = self

        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
                
        
        weatherManager.delegate = self
        searchTextField.delegate = self
        
        models.append(Model(time: "15:30", image: "sun.max.circle", temp: "25'"))
        models.append(Model(time: "16:30", image: "sun.max.circle", temp: "25'"))
        models.append(Model(time: "17:30", image: "sun.max.circle", temp: "25'"))
        models.append(Model(time: "18:30", image: "sun.max.circle", temp: "25'"))
        models.append(Model(time: "19:30", image: "sun.max.circle", temp: "25'"))
        models.append(Model(time: "20:30", image: "sun.max.circle", temp: "25'"))
        models.append(Model(time: "21:30", image: "sun.max.circle", temp: "25'"))
        models.append(Model(time: "22:30", image: "sun.max.circle", temp: "25'"))
        models.append(Model(time: "23:30", image: "sun.max.circle", temp: "25'"))
        models.append(Model(time: "24:30", image: "sun.max.circle", temp: "25'"))
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

