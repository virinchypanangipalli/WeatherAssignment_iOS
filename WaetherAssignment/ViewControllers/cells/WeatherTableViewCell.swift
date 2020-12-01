/********************************************************************************
 WeatherTableViewCell
 ********************************************************************************
 */
import UIKit

class WeatherTableViewCell : UITableViewCell {
    
    @IBOutlet weak var cityLabel : UILabel!
    @IBOutlet weak var tempLabel : UILabel!
    @IBOutlet weak var weatherIcon : UIImageView!
    
    func configureCell(_ weather: Weather.WeatherModel){
         self.cityLabel.text = weather.name
         self.tempLabel.text = "\(weather.main.temp)"+"°C"
    }
}
