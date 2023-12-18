import Foundation

struct SaleGameInfo: Game, Codable {
    
   
    var id: String { dealID }
    
    let internalName: String
    let title: String
    let metacriticLink: String
    let dealID: String
    let storeID: String
    let gameID: String
    let salePrice: String
    let normalPrice: String
    let isOnSale: String
    let savings: String
    let metacriticScore: String
    let steamRatingText: String
    let steamRatingPercent: String
    let steamRatingCount: String
    let steamAppID: String
    let releaseDate: Int
    let lastChange: Int
    let dealRating: String
    let thumb: String
    
    var releaseD: Date { Date(timeIntervalSince1970: TimeInterval(releaseDate)) }
    var developer: String? = nil
    
  
    var imageURL: String { thumb }
    var name: String { title }
    var rating: CGFloat
    var price: CGFloat { CGFloat(truncating: NumberFormatter().number(from: salePrice) ?? 0) }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.internalName = try container.decodeIfPresent(String.self, forKey: .internalName) ?? ""
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        self.metacriticLink = try container.decodeIfPresent(String.self, forKey: .metacriticLink) ?? ""
        self.dealID = try container.decodeIfPresent(String.self, forKey: .dealID) ?? ""
        self.storeID = try container.decodeIfPresent(String.self, forKey: .storeID) ?? ""
        self.gameID = try container.decodeIfPresent(String.self, forKey: .gameID) ?? ""
        self.salePrice = try container.decodeIfPresent(String.self, forKey: .salePrice) ?? ""
        self.normalPrice = try container.decodeIfPresent(String.self, forKey: .normalPrice) ?? ""
        self.isOnSale = try container.decodeIfPresent(String.self, forKey: .isOnSale) ?? ""
        self.savings = try container.decodeIfPresent(String.self, forKey: .savings) ?? ""
        self.metacriticScore = try container.decodeIfPresent(String.self, forKey: .metacriticScore) ?? ""
        self.steamRatingText = try container.decodeIfPresent(String.self, forKey: .steamRatingText) ?? ""
        self.steamRatingPercent = try container.decodeIfPresent(String.self, forKey: .steamRatingPercent) ?? ""
        self.steamRatingCount = try container.decodeIfPresent(String.self, forKey: .steamRatingCount) ?? ""
        self.steamAppID = try container.decodeIfPresent(String.self, forKey: .steamAppID) ?? ""
        self.releaseDate = try container.decodeIfPresent(Int.self, forKey: .releaseDate) ?? 0
        self.lastChange = try container.decodeIfPresent(Int.self, forKey: .lastChange) ?? 0
        self.dealRating = try container.decodeIfPresent(String.self, forKey: .dealRating) ?? ""
        self.thumb = try container.decodeIfPresent(String.self, forKey: .thumb) ?? ""
        self.rating = CGFloat.random(in: 3.5...4.8)
    }
}
