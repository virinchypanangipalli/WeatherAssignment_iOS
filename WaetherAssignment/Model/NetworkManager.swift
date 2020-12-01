/********************************************************************************
   NetworkManager
 ********************************************************************************
 */
import Foundation
class NetworkManager: NSObject {
    
    struct Key {
        
        static let weatherKey: String = "e46feb1c24d50c304e4066e3d0eee5b4"
        static let googleMaps: String = "AIzaSyA7CIaKsbp-nGV9KS-6GJqS3GM1q71TNzw"
        
    }
    
    private static let baseURLWeather = "http://api.openweathermap.org/data/2.5"
    private static let baseURLMap = "https://maps.googleapis.com/maps/api"
    
    struct APIURL {
        
        static func weatherRequestByGPS(longitude: Double, latitude: Double) -> String {
            return "\(baseURLWeather)/weather?lat=\(latitude)&lon=\(longitude)&appid=\(NetworkManager.Key.weatherKey)"
        }
        
        static func weatherRequestByCityID(cityID: String) -> String {
            return "\(baseURLWeather)/weather?id=\(cityID)&units=metric&&appid=\(NetworkManager.Key.weatherKey)"
        }
        
        static func weatherRequestForCities(cityID: [String]) -> String {
            let cities = cityID.joined(separator: ",")
            return "\(baseURLWeather)/group?id=\(cities)&units=metric&&appid=\(NetworkManager.Key.weatherKey)"
        }
        
        static func cityCompletion(for search: String) -> String {
            return "\(baseURLMap)/place/autocomplete/json?input=\(search)&types=(cities)&key=\(NetworkManager.Key.googleMaps)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        }
        
        static func cityData(for placeID: String) ->  String {
            return "\(baseURLMap)/place/details/json?placeid=\(placeID)&key=\(NetworkManager.Key.googleMaps)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        }
                
    }
        
}

