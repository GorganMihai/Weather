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
    @IBOutlet var updateTimeLabel: UILabel!
    
    
    
    var models = [WeatherModel]()
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
    
    func showApiKeyAlert(){
        let alert = UIAlertController(title: "The API key is missing", message: "Plese insert your API key in WeatherManager.swift from openweathermap.org", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
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
            if !weatherManager.fetchWeather(city) {
                showApiKeyAlert()
            }
            self.updateTimeLabel.text = setUpdateLabel()
        }
        
        searchTextField.text = ""
    }
}


//MARK: - WeatherManager

extension WeatherViewController: WeatherManagerDelegate {
    
    func didUpdateWeather (_ weatherManager: WeatherManager, weather: dailyWeatherModel){
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.cityLabel.text = weather.cityName
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.models.removeAll()
            for e in weather.dailyWeatherModel! {
                self.models.append(e)
            }
            //self.models.append(WeatherModel(time: "0000", image: "xmark.octagon", temp: "250^"))
            self.table.reloadData()
        }
}}

//MARK: - Location

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            if !weatherManager.fechWeather(lat, lon) {
                showApiKeyAlert()
            }
            self.updateTimeLabel.text = setUpdateLabel()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func setUpdateLabel() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return "Last Updated: \(formatter.string(from: Date.now))"
    }
   
}

