import Kingfisher
import SwiftUI

struct OnSaleView: View {
    @EnvironmentObject var data: DataManager
    
    @State var filter = ""
    var body: some View {
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                Text("On Sale")
                    .font(.system(size: 25, weight: .bold))
                
                HStack {
                    
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.black)
                    
                    TextField("Search", text: $filter)
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
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        Divider()
                        if data.filtered(array: data.onSaleGames).isEmpty {
                            Text("No Results")
                        } else {
                            ForEach(data.filtered(array: data.onSaleGames), id: \.hashValue) { g in
                                NavigationLink {
                                    SingleGameView(game: g.wrappedValue)
                                        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
                                } label: {
                                    HStack {
                                        KFImage(URL(string: g.wrappedValue.imageURL))
                                            .resizable()
                                            .frame(width: 40, height: 40)
                                            .clipShape(Circle())
                                        
                                        VStack(alignment: .leading) {
                                            Text(g.wrappedValue.name)
                                            
                                            if let s = g.wrappedValue as? SaleGameInfo {
                                                HStack {
                                                    Text("$\(s.salePrice)")
                                                        .strikethrough()
                                                        .foregroundStyle(.gray)
                                                    Text("$" + s.salePrice)
                                                        .foregroundStyle(Color("purple_color"))
                                                }
                                                .font(.system(size: 12))
                                            }
                                        }
                                        .foregroundColor(.white)
                                        
                                        Spacer()
                                        
                                        Image(systemName: "chevron.right")
                                            .imageScale(.large)
                                    }
                                    .padding(8)
                                }
                                
                                Divider()
                            }

                        }
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $data.showFilterView) {
            Filter()
                .environmentObject(data)
        }
        .onDisappear {
            data.filters = []
            data.pricePoints = nil
        }
    }
}

#Preview {
    Search()
        .preferredColorScheme(.dark)
}
