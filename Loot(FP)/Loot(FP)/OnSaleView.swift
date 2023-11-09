
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
                    
                    Image(systemName: "line.3.horizontal.decrease.circle")
                        .foregroundColor(.black)
                }
                .padding()
                .frame(width: width * 0.9, height: 45)
                .background(Color.white.cornerRadius(10))
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        Divider()
                        ForEach(data.onSaleGames.filter({ $0.title.contains(filter) || filter.isEmpty }), id: \.dealID) { g in
                            HStack {
                                KFImage(URL(string: g.thumb))
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                                
                                VStack(alignment: .leading) {
                                    Text(g.title)
                                    HStack {
                                        Text("$\(g.salePrice)")
                                            .strikethrough()
                                            .foregroundStyle(.gray)
                                        Text("$" + g.salePrice)
                                            .foregroundStyle(Color("purple"))
                                    }
                                    .font(.system(size: 12))
                                }
                                
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
