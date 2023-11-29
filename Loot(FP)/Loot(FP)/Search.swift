import SwiftUI
import Kingfisher

struct Search: View {
    
    @EnvironmentObject var data: DataManager
        
    var body: some View {
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                Text("Explore")
                    .font(.system(size: 25, weight: .bold))
                
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack {
                        HStack {
                            
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.black)
                            
                            TextField("Search", text: $data.filterText)
                                .foregroundColor(.black)
                            
                            Spacer()
                            
                            Button {
                                data.showFilterView.toggle()
                            } label: {
                                Image(systemName: "line.3.horizontal.decrease.circle")
                                    .foregroundColor(.black)
                            }
                        }
                        .padding()
                        .frame(width: width * 0.9, height: 45)
                        .background(Color.white.cornerRadius(10))
                        
                        Divider()
                        
                        ForEach(data.filtered(array: data.allGames), id: \.hashValue) { g in
                            NavigationLink {
                                if let s = g.wrappedValue as? SaleGameInfo {
                                    SingleGameView(game: s)
                                        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
                                } else if let s = g.wrappedValue as? FreeGameInfo {
                                    SingleGameView(game: s)
                                        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
                                } else if let s = g.wrappedValue as? UpcomingGameInfo {
                                    SingleGameView(game: s)
                                        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
                                }
                            } label: {
                                HStack {
                                    KFImage(URL(string: g.wrappedValue.imageURL))
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .clipShape(Circle())
                                    
                                    Text(g.wrappedValue.name)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .imageScale(.large)
                                }
                                .foregroundColor(.white)
                                .padding(.horizontal)
                                .padding(8)
                            }
                            
                            Divider()
                        }
                    }
                    
                    // Making Room For Content Because Of Tab Bar
                    VStack { }.frame(height: 60)
                }
            }
        }
        .sheet(isPresented: $data.showFilterView) {
            Filter()
                .environmentObject(data)
        }
        .onDisappear {
            data.filters = []
            data.pricePoints = PriceLevel.allCases
        }
    }
}

#Preview {
    Search()
        .environmentObject(DataManager())
        .preferredColorScheme(.dark)
}
