import SwiftUI
import Kingfisher

struct SingleGameView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \WishList.timestamp, ascending: true)],
        animation: .default)
    private var wish: FetchedResults<WishList>
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Owned.timestamp, ascending: true)],
        animation: .default)
    private var owned: FetchedResults<Owned>
    
    let game: any Game
    
    @State var selection = 0
    
    var body: some View {
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                KFImage(URL(string: game.imageURL))
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.3)
                    .overlay(alignment: .topLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .imageScale(.large)
                                .foregroundColor(.white)
                        }
                        .padding(10)
                        .background(Circle().fill(.accent))
                        .padding(.top, 50)
                        .padding(.leading, 20)
                    }
                
                HStack {
                    
                    KFImage(URL(string: game.imageURL))
                        .resizable()
                        .cornerRadius(10)
                        .scaledToFit()
                        .frame(width: 56, height: 56)
                    
                    VStack(alignment: .leading) {
                        Text(game.name)
                            .font(.body.bold())
                        
                        if let g = game as? SaleGameInfo {
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
                            .foregroundColor(.white)
                        }
                    }
                    
                    Spacer()
                    
                    Button {
                        addToWish()
                    } label: {
                        Image(systemName: "heart\(wish.contains(where: { $0.name == game.name }) ? ".fill" : "")")
                            .imageScale(.large)
                    }
                    
                    Button {
                        addToOwned()
                    } label: {
                        Image(systemName: "bookmark\(owned.contains(where: { $0.name == game.name }) ? ".fill" : "")")
                            .imageScale(.large)
                    }
                }
                .padding(.top, 20)
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: nil) {
                    HStack {
                        Text(game.releaseD > Date() ? "Release Date:" : "Released On:")
                            .fontWeight(.bold)
                        
                        Text(game.releaseD, style: .date)
                    }
                    .foregroundColor(.gray)
                    
                    if let d = game.developer {
                        HStack {
                            Text("Developed By:")
                                .fontWeight(.bold)
                            
                            Text(d)
                        }
                        .foregroundColor(.gray)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                
                Divider()
                
                HStack(spacing: 0) {
                                        
                    Button("Requirements") {
                        withAnimation { selection = 0 }
                    }
                    .foregroundColor(.white)
                    .frame(width: width * 0.5)
                    
                    Button("Details") {
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
                        .fill(Color("purple"))
                        .frame(width: width * 0.5, height: 5)
                        
                    if selection == 0 { Spacer() }
                }
                
                TabView(selection: $selection) {
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        VStack { }.frame(height: 10)
                        
                        Text("System Requirements")
                            .font(.title)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding()
                    .tag(0)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        VStack { }.frame(height: 10)
                        
                        Text("Description")
                            .font(.title)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding()
                    .tag(1)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
        }
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
    
    private func addToWish() {
        withAnimation {
            let newItem = WishList(context: PersistenceController.shared.container.viewContext)
            newItem.timestamp = Date()
            newItem.imageUrl = URL(string: game.imageURL)
            newItem.name = game.name
            newItem.price = Int64(game.price)
            if let s = game as? SaleGameInfo {
                newItem.salePrice = Int64(Double(s.salePrice) ?? 0)
            }
            
            do {
                try PersistenceController.shared.container.viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func addToOwned() {
        withAnimation {
            let newItem = Owned(context: PersistenceController.shared.container.viewContext)
            newItem.timestamp = Date()
            newItem.imageUrl = URL(string: game.imageURL)
            newItem.name = game.name
            newItem.price = Int64(game.price)
            if let s = game as? SaleGameInfo {
                newItem.salePrice = Int64(Double(s.salePrice) ?? 0)
            }

            do {
                try PersistenceController.shared.container.viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
