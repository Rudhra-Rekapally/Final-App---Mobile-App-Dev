import Foundation

struct UpcomingGameRes: Codable {
    let data: [UpcomingGameInfo]
}

struct UpcomingGameInfo: Game, Hashable, Codable {
    static func == (lhs: UpcomingGameInfo, rhs: UpcomingGameInfo) -> Bool {
        lhs._id == rhs._id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var developer: String? = nil
    
    var imageURL: String { images.gamemaker }
    
    var rating: CGFloat { 0 }
    
    var price: CGFloat { 0 }
    
    var id: String { _id }
    
    let _id: String
    let name: String
    let images: Images
    let created: String
    let updated: String
    let published: String
    let release: String
    let platforms: [Platform]
    
    var releaseD: Date { release.iso8601withFractionalSeconds }
}

struct Images: Codable {
    let banner: String
    let bannerZoom: String
    let gamemaker: String
    let gamemakerZoom: String
    let thumbnail: String
}

struct Platform: Codable {
    let name: String
    let tag: String
}
