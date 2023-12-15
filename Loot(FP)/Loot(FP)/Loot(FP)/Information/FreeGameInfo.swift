import Foundation

struct FreeGameInfo: Game, Codable {
    
    let id: Int
    let title: String
    let thumbnail: String
    let shortDescription: String
    let gameURL: String
    let genre: String
    let platform: String
    let publisher: String
    let developer: String?
    let releaseDate: String
    let freetogameProfileURL: String
    
    var releaseD: Date { releaseDate.iso8601withFractionalSeconds }
    
    /// Game Protocol
    var imageURL: String { thumbnail }
    var name: String { title }
    var rating: CGFloat
    
    /// Making Price 0 Since The Game Is Free
    var price: CGFloat { 0 }
    
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
        self.rating = CGFloat.random(in: 3.5...4.8)
    }
    
    init(id: Int = 1, title: String = "Test Game", thumbnail: String, shortDescription: String, gameURL: String, genre: String, platform: String, publisher: String, developer: String, releaseDate: String, freetogameProfileURL: String, rating: CGFloat) {
        self.id = id
        self.title = title
        self.thumbnail = thumbnail
        self.shortDescription = shortDescription
        self.gameURL = gameURL
        self.genre = genre
        self.platform = platform
        self.publisher = publisher
        self.developer = developer
        self.releaseDate = releaseDate
        self.freetogameProfileURL = freetogameProfileURL
        self.rating = rating
    }
}
