import Kingfisher
import SwiftUI

struct FreeToPlayView: View {
    @EnvironmentObject var data: DataManager
    var body: some View {
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                Text("Free To Play")
                    .font(.system(size: 25, weight: .bold))
                
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
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        Divider()
                        if data.filtered(array: data.freeGames).isEmpty {
                            Text("No Results")
                        } else {
                            ForEach(data.filtered(array: data.freeGames), id: \.hashValue) { g in
                                NavigationLink {
                                    SingleGameView(game: g.wrappedValue)
                                        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
                                } label: {
                                    HStack {
                                        KFImage(URL(string: g.wrappedValue.imageURL))
                                            .resizable()
                                            .frame(width: 40, height: 40)
                                            .clipShape(Circle())
                                        
                                        Text(g.wrappedValue.name)
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
            data.filterText = ""
            data.filters = []
            data.pricePoints = nil
        }
    }
}

#Preview {
    Search()
        .preferredColorScheme(.dark)
}
