import Foundation

// Define Codable structs to represent the JSON response
struct GenreResponse: Codable {
    let data: [Genre]
}

struct Genre: Codable {
    let id: String
    let type: String
    let href: String
    let attributes: GenreAttributes
}

struct GenreAttributes: Codable {
    let name: String
    let parentName: String?
    let parentId: String?
}
