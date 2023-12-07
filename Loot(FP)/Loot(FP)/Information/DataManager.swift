import Foundation
import Accelerate
import Alamofire
import SwiftUI

class DataManager: ObservableObject {
    
    /// The Different Filters
    @Published var filters = [FilterType]()
    
    /// The Selected Price Points (By Default All Of Them)
    @Published var pricePoints: PriceLevel? = nil
    
    /// Show The Filter View
    @Published var showFilterView = false
    
    /// All The Games For The Search Page
    var allGames: [any Game] { onSaleGames + freeGames + upcomingGames }
        
    @Published var onSaleGames = [SaleGameInfo]()
    @Published var freeGames = [FreeGameInfo]()
    @Published var upcomingGames = [UpcomingGameInfo]()
    @Published var lootOfTheDay = [SaleGameInfo]()
    
    @Published var loading = true
    
    @Sendable func fetch() async {
        await withCheckedContinuation { c in
            AF.request("https://www.cheapshark.com/api/1.0/deals?pageSize=30")
                .validate()
                .response { af in
                    guard let data = af.data else { return }
                    self.onSaleGames = Array(try! JSONDecoder().decode([SaleGameInfo].self, from: data))
                    self.lootOfTheDay.append(contentsOf: self.onSaleGames.choose(3))
                    c.resume()
                }
        }
        
        await withCheckedContinuation { c in
            AF.request("https://www.freetogame.com/api/games")
                .validate()
                .response { af in
                    guard let data = af.data else { return }
                    self.freeGames = Array(try! JSONDecoder().decode([FreeGameInfo].self, from: data))
                    c.resume()
                }
        }
        
        await withCheckedContinuation { c in
            AF.request(
                "https://video-game-calendar-release.p.rapidapi.com/?limit=10&skip=0",
                headers: [
                    "X-RapidAPI-Key": "3a68e252bcmsh2cf99e75f106654p1211b5jsnf5e47120e752",
                    "X-RapidAPI-Host": "video-game-calendar-release.p.rapidapi.com"
                ]
            )
            .response { af in
                guard let data = af.data else { return }
                self.upcomingGames = Array((try? JSONDecoder().decode(UpcomingGameRes.self, from: data).data) ?? [])
                print(String(decoding: data, as: UTF8.self))
                c.resume()
            }
        }
        
        DispatchQueue.main.async { withAnimation { self.loading = false } }
    }
    
    @Published var filterText = ""
    
    func filtered(array: [any Game]) -> Binding<[any Game]> {
        
        var toBeFiltered = array
        
        // Implementing The Filters
        filters.forEach { f in
            switch f {
            case .mostPopular:
                toBeFiltered = toBeFiltered.filter { $0.rating > 4 }
            case .recommended:
                toBeFiltered = toBeFiltered.filter { t in lootOfTheDay.contains(where: { $0.imageURL == t.imageURL }) }
            case .steamGames:
                break
            case .epicGames:
                break
            case .onSale:
                toBeFiltered = toBeFiltered.filter { $0 as? SaleGameInfo != nil }
            case .freeToPlay:
                toBeFiltered = toBeFiltered.filter { $0 as? FreeGameInfo != nil }
            case .upcomingGames:
                break
            }
        }
        
        // Filtering By Price Point
        toBeFiltered = toBeFiltered.filter { s in self.pricePoints == nil || pricePoints?.range.contains(s.price) == true }
        
        // Filtering By Text
        toBeFiltered = toBeFiltered.filter({ $0.name.contains(filterText) || filterText.isEmpty })
        
        let up = toBeFiltered.filter { $0 as? UpcomingGameInfo != nil }.map { $0 as! UpcomingGameInfo }.removingDuplicates()
        let sa = toBeFiltered.filter { $0 as? SaleGameInfo != nil }.map { $0 as! SaleGameInfo }.removingDuplicates()
        let free = toBeFiltered.filter { $0 as? FreeGameInfo != nil }.map { $0 as! FreeGameInfo }.removingDuplicates()
        
        return Binding { up + sa + free } set: { v in }
    }
}

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
