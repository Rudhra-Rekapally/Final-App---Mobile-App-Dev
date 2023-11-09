
import Foundation

struct FreeGameInfo: Codable {
    let id: Int
    let title: String
    let thumbnail: String
    let shortDescription: String
    let gameURL: String
    let genre: String
    let platform: String
    let publisher: String
    let developer: String
    let releaseDate: String
    let freetogameProfileURL: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        self.thumbnail = try container.decodeIfPresent(String.self, forKey: .thumbnail) ?? ""
        self.shortDescription = try container.decodeIfPresent(String.self, forKey: .shortDescription) ?? ""
        self.gameURL = try container.decodeIfPresent(String.self, forKey: .gameURL) ?? ""
        self.genre = try container.decodeIfPresent(String.self, forKey: .genre) ?? ""
        self.platform = try container.decodeIfPresent(String.self, forKey: .platform) ?? ""
        self.publisher = try container.decodeIfPresent(String.self, forKey: .publisher) ?? ""
        self.developer = try container.decodeIfPresent(String.self, forKey: .developer) ?? ""
        self.releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate) ?? ""
        self.freetogameProfileURL = try container.decodeIfPresent(String.self, forKey: .freetogameProfileURL) ?? ""
    }
}
