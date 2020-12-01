/********************************************************************************
 WeatherDetailViewController
 ********************************************************************************
 */

import UIKit


class WeatherDetailViewController: UIViewController {
    
    @IBOutlet weak var locationLabel: UILabel!
   
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var minmaxLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    
    var cityId:String!

    override func viewDidLoad() {
        self.view.backgroundColor = .white
        
     //TODO : Map data
        
        WeatherManager.getWeather(forCity: cityId ) { (weather) in
            
            DispatchQueue.main.async {
            
                if let weatherDetails = weather {
                  self.updateData(weather: weatherDetails )
                }
            }
        
    }
    }
    
    private func updateData(weather:Weather.WeatherModel){
        
        locationLabel.text = weather.name
        temperatureLabel.text = "\(weather.main.temp)" + "°C"
        feelsLikeLabel.text = "Feels like \(weather.main.feels_like)"
        humidityLabel.text = "Humidity \(weather.main.humidity)"
        minmaxLabel.text = "Min: \(weather.main.temp_min) - Max : \(weather.main.temp_max)"
        if let description  = weather.weather.first?.description{
            descriptionLabel.text = description
        }
    }
}
   
    

