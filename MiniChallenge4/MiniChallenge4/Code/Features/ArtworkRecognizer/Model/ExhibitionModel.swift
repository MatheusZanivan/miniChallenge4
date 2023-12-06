import Foundation

struct Exhibition: Codable, Identifiable {
    let id: Int
    let name: String
    let author: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idExhibition"
        case name
        case author
        case description
    }
}

struct JsonData: Decodable {
    let exhibitions: [Exhibition]
}

