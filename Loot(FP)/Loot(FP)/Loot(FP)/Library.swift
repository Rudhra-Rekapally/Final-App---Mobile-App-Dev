import SwiftUI
import Kingfisher

struct Library: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var selection = 0
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \WishList.timestamp, ascending: true)],
        animation: .default)
    private var wish: FetchedResults<WishList>
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Owned.timestamp, ascending: true)],
        animation: .default)
    private var owned: FetchedResults<Owned>
    
    var body: some View {
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                Text("Saved")
                    .font(.system(size: 30, weight: .bold))
                
                HStack(spacing: 0) {
                                        
                    Button("Wishlist") {
                        withAnimation { selection = 0 }
                    }
                    .foregroundColor(.white)
                    .frame(width: width * 0.5)
                    
                    Button("Library") {
                        withAnimation { selection = 1 }
                    }
                    .foregroundColor(.white)
                    .frame(width: width * 0.5)
                }
                .font(.system(size: 23, weight: .semibold))
                .padding(.top)
                
                HStack(spacing: 0) {
                    
                    if selection == 1 { Spacer() }
                    
                    Rectangle()
                        .fill(Color("purple_color"))
                        .frame(width: width * 0.5, height: 5)
                        
                    if selection == 0 { Spacer() }
                }
                
                TabView(selection: $selection)  {
                    List {
                        ForEach(wish) { w in
                            HStack {
                                KFImage(w.imageUrl)
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                                
                                VStack(alignment: .leading) {
                                    Text(w.name ?? "")
                                    
                                    if w.price > 0 && w.salePrice > 0 {
                                        HStack {
                                            Text("$\(w.price)")
                                                .strikethrough()
                                                .foregroundStyle(.gray)
                                            Text("$" + w.salePrice.description)
                                                .foregroundStyle(Color("purple_color"))
                                        }
                                        .font(.system(size: 12))
                                    }
                                }
                                .foregroundColor(.white)
                                
                                Spacer()
                                
                                Button {
                                    guard let i = wish.firstIndex(where: { $0.name == w.name }) else { return }
                                    deleteWish(offsets: [i])
                                } label: {
                                    Image(systemName: "minus.circle")
                                        .foregroundColor(.red)
                                        .imageScale(.large)
                                }
                            }
                            .padding(8)
                            .listRowBackground(Color.clear)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        }
                        .onDelete(perform: deleteWish)
                    }
                    .listStyle(.plain)
                    .tag(0)
                    
                    List {
                        ForEach(owned) { w in
                            HStack {
                                KFImage(w.imageUrl)
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                                
                                VStack(alignment: .leading) {
                                    Text(w.name ?? "")
                                    
                                    if w.price > 0 && w.salePrice > 0 {
                                        HStack {
                                            Text("$\(w.price)")
                                                .strikethrough()
                                                .foregroundStyle(.gray)
                                            Text("$" + w.salePrice.description)
                                                .foregroundStyle(Color("purple_color"))
                                        }
                                        .font(.system(size: 12))
                                    }
                                }
                                .foregroundColor(.white)
                                
                                Spacer()
                                
                                Button {
                                    guard let i = owned.firstIndex(where: { $0.name == w.name }) else { return }
                                    deleteOwned(offsets: [i])
                                } label: {
                                    Image(systemName: "minus.circle")
                                        .foregroundColor(.red)
                                        .imageScale(.large)
                                }
                            }
                            .padding(8)
                            .listRowBackground(Color.clear)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        }
                        .onDelete(perform: deleteOwned)
                    }
                    .listStyle(.plain)
                    .tag(1)
                }
                .scrollContentBackground(.hidden)
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
        }
        .onAppear {
              UIScrollView.appearance().isScrollEnabled = false
        }
    }
    
    private func deleteWish(offsets: IndexSet) {
        withAnimation {
            offsets.map { wish[$0] }.forEach(viewContext.delete)
            
            try? viewContext.save()
        }
    }
    
    private func deleteOwned(offsets: IndexSet) {
        withAnimation {
            offsets.map { owned[$0] }.forEach(viewContext.delete)
            
            try? viewContext.save()
        }
    }
}

#Preview {
    Library()
        .preferredColorScheme(.dark)
}
