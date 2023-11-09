
import Foundation
import Alamofire

class DataManager: ObservableObject {
    
    @Published var onSaleGames = [SaleGameInfo]()
    @Published var freeGames = [FreeGameInfo]()
    @Published var lootOfTheDay = [SaleGameInfo]()
    
    func fetch() {
        AF.request("https://www.cheapshark.com/api/1.0/deals")
            .validate()
            .response { af in
                guard let data = af.data else { return }
                self.onSaleGames = try! JSONDecoder().decode([SaleGameInfo].self, from: data)
                self.lootOfTheDay.append(contentsOf: self.onSaleGames.choose(3))
            }
        
        AF.request("https://www.freetogame.com/api/games")
            .validate()
            .response { af in
                guard let data = af.data else { return }
                self.freeGames = try! JSONDecoder().decode([FreeGameInfo].self, from: data)
            }
        
    }
}
