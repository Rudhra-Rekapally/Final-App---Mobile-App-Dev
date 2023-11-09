
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
                        
                        VStack {
                            
                            Text("Loot of the day")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.title)
                            
                            
                            ScrollView(.horizontal) {
                                HStack(alignment: .top) {
                                    ForEach(data.lootOfTheDay, id: \.dealID) { g in
                                        GameCell(image: g.thumb, title: g.title, g: g)
                                    }
                                }
                            }
                            .padding(.top)
                        }
                        .padding()
                        
                        VStack {
                            
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
                                HStack {
                                    ForEach(data.freeGames, id: \.id) { g in
                                        GameCell(image: g.thumbnail, title: g.title)
                                    }
                                }
                            }
                            .padding(.top)
                        }
                        .padding()
                        
                        VStack {
                            
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
                                        GameCell(image: g.thumb, title: g.title, g: g)
                                    }
                                }
                            }
                            .padding(.top)
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
        .preferredColorScheme(.dark)
}

struct GameCell: View {
    
    let image: String
    let title: String
    let g: SaleGameInfo?
    
    @State var rating: Float = 2
    
    init(image: String, title: String, g: SaleGameInfo? = nil) {
        self.image = image
        self.title = title
        self.g = g
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            KFImage(URL(string: image)!)
                .resizable()
                .scaledToFit()
                .cornerRadius(10)
                .frame(width: 150, height: 165)
            
            Text("base game".uppercased())
                .font(.system(size: 12, weight: .semibold))
                .fixedSize(horizontal: false, vertical: true)
                .foregroundStyle(.gray)
            
            Text(title)
            
            if let g {
                HStack {
                    Text("-\(Double(g.savings) ?? 0, specifier: "%.0f")%")
                        .font(.system(size: 12))
                        .fixedSize()
                        .padding(5)
                        .background(Color("purple"))
                    
                    Text("$\(g.normalPrice)")
                        .font(.system(size: 11))
                        .minimumScaleFactor(0.7)
                        .fixedSize()
                        .strikethrough()
                        .foregroundStyle(.gray)
                    
                    Text("$\(g.salePrice)")
                }
                .font(.system(size: 12))
            } else {
                Text("Free to play")
                    .font(.system(size: 10, weight: .medium))
                    .minimumScaleFactor(0.7)
                    .fixedSize()
                    .foregroundStyle(.gray)
                    .padding(.top, 4)
            }
            
            StarRatingView(rating: Binding { rating } set: { v in })
                .frame(width: 150, height: 20)
        }
        .frame(width: 150)
        .onAppear { rating = Float.random(in: 3.5...4.8) }
    }
}
