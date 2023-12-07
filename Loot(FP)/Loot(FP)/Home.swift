import Alamofire
import SwiftUI
import Kingfisher
import StarRatingViewSwiftUI

struct Home: View {
    @State var search = ""
    
    @Binding var selection: Int
    
    @EnvironmentObject var data: DataManager

    var body: some View {
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                Text("Home")
                    .font(.system(size: 25, weight: .bold))
                
                Button {
                    withAnimation { selection = 0 }
                } label: {
                    HStack {
                        
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.black)
                        
                        Text("Search")
                            .foregroundColor(.gray)
                        
                        Spacer()
                        
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .foregroundColor(.black)
                    }
                    .padding()
                    .frame(width: width * 0.9, height: 45)
                    .background(Color.white.cornerRadius(10))
                }
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        
                        VStack(spacing: 0) {

                            Text("Loot of the day")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.title)
                            
                            
                            ScrollView(.horizontal) {
                                LazyHStack(alignment: .top) {
                                    ForEach(data.lootOfTheDay, id: \.dealID) { g in
                                        GameCell(game: g)
                                    }
                                }
                            }
                            .padding(.top, 8)
                        }
                        .padding()
                        
                        VStack(spacing: 0) {

                            HStack {
                                
                                Text("Free To Play")
                                    .font(.title)
                                
                                Spacer()
                                
                                NavigationLink {
                                    FreeToPlayView()
                                        .environmentObject(data)
                                } label: {
                                    Text("view all")
                                        .foregroundColor(.gray)
                                }
                            }
                            
                            ScrollView(.horizontal) {
                                LazyHStack {
                                    ForEach(data.freeGames, id: \.id) { g in
                                        GameCell(game: g)
                                    }
                                }
                            }
                            .padding(.top, 8)
                        }
                        .padding()
                        
                        VStack(spacing: 0) {
                            
                            HStack {
                                
                                Text("On Sale")
                                    .font(.title)
                                
                                Spacer()
                                
                                NavigationLink {
                                    OnSaleView()
                                        .environmentObject(data)
                                } label: {
                                    Text("view all")
                                        .foregroundColor(.gray)
                                }
                            }
                            
                            ScrollView(.horizontal) {
                                HStack(alignment: .top) {
                                    ForEach(data.onSaleGames, id: \.dealID) { g in
                                        GameCell(game: g)
                                    }
                                }
                            }
                            .padding(.top, 5)
                        }
                        .padding()
                        
                        VStack(spacing: 0) {

                            HStack {
                                
                                Text("Upcoming Games")
                                    .font(.title)
                                
                                Spacer()
                                
                                NavigationLink {
                                    UpcomingView()
                                        .environmentObject(data)
                                } label: {
                                    Text("view all")
                                        .foregroundColor(.gray)
                                }
                            }
                            
                            ScrollView(.horizontal) {
                                LazyHStack(alignment: .top) {
                                    ForEach(data.upcomingGames) { g in
                                        GameCell(game: g)
                                    }
                                }
                            }
                            .padding(.top, 8)
                        }
                        .padding()
                        
                    }
                    
                    VStack { }.frame(height: 80)
                }
            }
        }
        .navigationTitle("Home")
        .navigationBarHidden(true)
    }
}

#Preview {
    Home(selection: .constant(1))
        .environmentObject(DataManager())
        .preferredColorScheme(.dark)
}

struct GameCell<G: Game>: View {
    
    let game: G
    
    var body: some View {
        NavigationLink {
            SingleGameView(game: game)
                .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
        } label: {
            VStack(alignment: .leading) {
                KFImage(URL(string: game.imageURL)!)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
                    .frame(width: 150, height: 165)
                
                Text("base game".uppercased())
                    .font(.system(size: 12, weight: .semibold))
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundStyle(.gray)
                
                Text(game.name)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.white)
                
                if let g = game as? SaleGameInfo {
                    HStack {
                        Text("-\(Double(g.savings) ?? 0, specifier: "%.0f")%")
                            .font(.system(size: 12))
                            .fixedSize()
                            .padding(5)
                            .background(Color("purple_color"))
                        
                        Text("$\(g.normalPrice)")
                            .font(.system(size: 11))
                            .minimumScaleFactor(0.7)
                            .fixedSize()
                            .strikethrough()
                            .foregroundStyle(.gray)
                        
                        Text("$\(g.salePrice)")
                    }
                    .font(.system(size: 12))
                    .foregroundColor(.white)
                } else if let g = game as? UpcomingGameInfo {
                    HStack(spacing: 0) {
                        Text("Coming ")
                        
                        Text(g.releaseD, style: .date)
                    }
                    .font(.system(size: 10, weight: .medium))
                    .minimumScaleFactor(0.7)
                    .fixedSize()
                    .foregroundStyle(.gray)
                    .padding(.top, 4)
                } else {
                    Text("Free to play")
                        .font(.system(size: 10, weight: .medium))
                        .minimumScaleFactor(0.7)
                        .fixedSize()
                        .foregroundStyle(.gray)
                        .padding(.top, 4)
                    
                }
                
                StarRatingView(rating: Binding { Float(game.rating) } set: { v in })
                    .frame(width: 150, height: 20)
            }
            .frame(width: 150)
        }
    }
}
