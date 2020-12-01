/********************************************************************************
 WeatherManager
 ********************************************************************************
 */

import Foundation


class WeatherManager {
    
    static func getWeather(forCity city: String, _ completion: @escaping (_ weather: Weather.WeatherModel?) -> Void) {
        guard let url = URL(string: NetworkManager.APIURL.weatherRequestByCityID(cityID:city)) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .secondsSince1970
                
                let weatherObject = try decoder.decode(Weather.WeatherModel.self, from: data)
                completion(weatherObject)
            } catch {
                print(error.localizedDescription)
                completion(nil)
            }
        }.resume()
    }
    
    
    static func getWeather(forCities cities: [String], _ completion: @escaping (_ weather: Weather.Weatherlist?) -> Void) {
        guard let url = URL(string: NetworkManager.APIURL.weatherRequestForCities(cityID: cities)) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .secondsSince1970
                
                let weatherObject = try decoder.decode(Weather.Weatherlist.self, from: data)
                
                completion(weatherObject)
            } catch {
                print(error.localizedDescription)
                completion(nil)
            }
        }.resume()
    }
    
}
