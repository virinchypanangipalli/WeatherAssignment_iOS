/********************************************************************************
 Weather
 ********************************************************************************
 */

import Foundation

class Weather {
    
    struct Coord: Codable {
        let lon: Float
        let lat: Float
    }
    
    struct Weather: Codable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
    
    struct Main: Codable {
        let temp: Float
        let feels_like: Float
        let temp_min: Float
        let temp_max: Float
        let pressure: Float
        let humidity: Float
    }
    
    struct Sys: Codable {
        let country: String?
        let sunrise: Int?
        let sunset: Int?
    }
    
    struct WeatherModel: Codable {
        let coord: Coord
        let weather: [Weather]
        let main: Main
        let sys: Sys
        let name: String?
        let dt: Int
        let id: Int
        let timezone: Int?
        let dt_text: String?
    }
    
    struct Weatherlist: Codable {
        let cnt: Int
        let list: [WeatherModel]
    }
}



