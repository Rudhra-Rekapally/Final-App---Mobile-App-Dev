
import Kingfisher
import SwiftUI

struct FreeToPlayView: View {
    @EnvironmentObject var data: DataManager
    @State var filter = ""
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
                    
                    TextField("Search", text: $filter)
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Image(systemName: "line.3.horizontal.decrease.circle")
                        .foregroundColor(.black)
                }
                .padding()
                .frame(width: width * 0.9, height: 45)
                .background(Color.white.cornerRadius(10))
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        Divider()
                        ForEach(data.freeGames.filter({ $0.title.contains(filter) || filter.isEmpty }), id: \.id) { g in
                            HStack {
                                KFImage(URL(string: g.thumbnail))
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                                
                                Text(g.title)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .imageScale(.large)
                            }
                            .padding(8)
                            
                            Divider()
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    Search()
        .preferredColorScheme(.dark)
}
