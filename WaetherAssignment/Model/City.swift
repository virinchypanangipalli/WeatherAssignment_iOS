/********************************************************************************
 City
 ********************************************************************************
 */


import Foundation

struct City: Codable {
    
    let id: Int?
    let name: String?
    let coord: Coord?
    let country: String?
  
}

struct Coord: Codable {
    let lon: Float
    let lat: Float
}
