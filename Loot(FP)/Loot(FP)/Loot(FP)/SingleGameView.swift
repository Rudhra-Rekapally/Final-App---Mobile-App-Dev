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
    
    let requirements = [
        ("OS", "Windows 10 (64 bit)"),
        ("Processor", "AMD Ryzen 3 1200/Intel Core i5-7500"),
        ("Memory", "8 GB RAM"),
        ("Graphics", "AMD Radeon RX 560 with 4GB VRAM/NVIDIA GeForce GTX 1050 Ti with 4GB VRAM"),
        ("DirectX", "Version 12")
    ]
    
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
                        }
                    }
                    
                    Spacer()
                    
                    Button {
                        if let i = wish.firstIndex(where: { $0.name == game.name }) {
                            deleteWish(offsets: [i])
                        } else {
                            addToWish()
                        }
                    } label: {
                        Image(systemName: "heart\(wish.contains(where: { $0.name == game.name }) ? ".fill" : "")")
                            .imageScale(.large)
                    }
                    
                    Button {
                        if let i = owned.firstIndex(where: { $0.name == game.name }) {
                            deleteOwned(offsets: [i])
                        } else {
                            addToOwned()
                        }
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
                        .fill(Color("purple_color"))
                        .frame(width: width * 0.5, height: 5)
                        
                    if selection == 0 { Spacer() }
                }
                
                TabView(selection: $selection) {
                    ScrollView(.vertical, showsIndicators: false) {
                                                
                        Text("System Requirements")
                            .font(.title)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("minimum".uppercased())
                            .font(.system(size: 20, weight: .bold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical, 8)
                        
                        ForEach(requirements, id: \.0) { r in
                            Text("\(r.0): ")
                                .foregroundStyle(.gray1)
                                .fontWeight(.bold) + Text(r.1)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("Additional Notes: ")
                            .foregroundStyle(.gray1)
                            .fontWeight(.bold)
                        ForEach(["Estimated performance: 1080p/60fps", "Framerate might drop in graphics-intensive scenes. ", "AMD Radeon RX 6700 XT or NVIDIA GeForce RTX 2070 required to support ray tracing."], id: \.self) { i in
                            Text(" • \(i)")
                        }
                    }
                    .padding(.horizontal)
                    .tag(0)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                                                
                        VStack(alignment: .leading) {
                            Text("Description")
                                .font(.title)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text("Described as \"soccer, but with rocket-powered cars\", Rocket League has up to eight players assigned to each of the two teams, using rocket-powered vehicles to hit a ball into their opponent's goal and score points over the course of a match. ")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundStyle(Color(hex: "#A8A8A8"))
                                .padding(.top, 3)
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Screenshots")
                                .font(.title)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach([("s1", 0), ("s2", 1), ("s1", 2), ("s2", 3)], id: \.1) { s, i in
                                        Image(s)
                                            .resizable()
                                            .frame(width: 265, height: 150)
                                            .padding(.horizontal)
                                    }
                                }
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Genre")
                                .font(.title)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top)
                            
                            Text("ACTON, ADVENTURE, ROLEPLAY")
                                .foregroundColor(Color(hex: "#A8A8A8"))
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Availability")
                                .font(.title)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top)
                            
                            HStack {
                                Text("2022")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(hex: "#A8A8A8"))
                                
                                HStack {
                                    Image(systemName: "star.fill")
                                        .imageScale(.small)
                                        .foregroundColor(Color(hex: "#FFC83A"))
                                    
                                    Text("\(game.rating, specifier: "%.1f")")
                                        .foregroundColor(Color(hex: "#A8A8A8"))
                                }
                                .padding(.horizontal, 8)
                                
                                Image(.xbox)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .padding(.horizontal, 5)

                                Image(.playstation)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .padding(.horizontal, 5)

                                Image(.windoes)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .padding(.horizontal, 5)
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Price")
                                .font(.title)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top)
                            
                            ZStack {
                                Group {
                                    Color(hex: "#A788CE")
                                        .cornerRadius(4)
                                        .opacity(0.5)
                                    
                                    HStack {
                                        
                                        Text("Buy \(game.name)")
                                        
                                        Spacer()
                                        
                                        Image(.windoes)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 20, height: 20)
                                    }
                                    .padding(.horizontal, 7)
                                }
                                .frame(width: UIScreen.main.bounds.width * 0.9, height: 45)
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.9, height: 80)
                            .overlay(alignment: .bottomTrailing) {
                                ZStack {
                                    Color.black
                                        .cornerRadius(2)
                                        .frame(width: 114, height: 26)
                                    
                                    Text(game.price == 0 ? "Free" : "\(game.price, specifier: "%.2f")")
                                        .foregroundColor(.white)
                                        .font(.system(size: 10))
                                        .frame(width: 55, height: 22)
                                        .background(Color(hex: "#A788CE").cornerRadius(1))
                                }
                            }
                            
                            ZStack {
                                Group {
                                    Color(hex: "#A788CE")
                                        .cornerRadius(4)
                                        .opacity(0.5)
                                    
                                    HStack {
                                        
                                        Text("Buy \(game.name)")
                                        
                                        Spacer()
                                        
                                        Image(.playstation)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 20, height: 20)
                                    }
                                    .padding(.horizontal, 7)
                                }
                                .frame(width: UIScreen.main.bounds.width * 0.9, height: 45)
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.9, height: 80)
                            .overlay(alignment: .bottomTrailing) {
                                ZStack {
                                    Color.black
                                        .cornerRadius(2)
                                        .frame(width: 114, height: 26)
                                    
                                    Text(game.price == 0 ? "Free" : "\(game.price, specifier: "%.2f")")
                                        .foregroundColor(.white)
                                        .font(.system(size: 10))
                                        .frame(width: 55, height: 22)
                                        .background(Color(hex: "#A788CE").cornerRadius(1))
                                }
                            }
                            
                            ZStack {
                                Group {
                                    Color(hex: "#A788CE")
                                        .cornerRadius(4)
                                        .opacity(0.5)
                                    
                                    HStack {
                                        
                                        Text("Buy \(game.name)")
                                        
                                        Spacer()
                                        
                                        Image(.xbox)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 20, height: 20)
                                    }
                                    .padding(.horizontal, 7)
                                }
                                .frame(width: UIScreen.main.bounds.width * 0.9, height: 45)
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.9, height: 80)
                            .overlay(alignment: .bottomTrailing) {
                                ZStack {
                                    Color.black
                                        .cornerRadius(2)
                                        .frame(width: 114, height: 26)
                                    
                                    Text(game.price == 0 ? "Free" : "\(game.price, specifier: "%.2f")")
                                        .foregroundColor(.white)
                                        .font(.system(size: 10))
                                        .frame(width: 55, height: 22)
                                        .background(Color(hex: "#A788CE").cornerRadius(1))
                                }
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Community Review")
                                .font(.title)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top)
                            
                            HStack {
                                VStack {
                                    ZStack {
                                        Circle()
                                            .trim(from: 0, to: 0.94)
                                            .stroke(Color(hex: "#FF6E57"), style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
                                            .frame(width: 80, height: 80)
                                            .rotationEffect(.degrees(-90))
                                        
                                        Text("94%")
                                    }
                                    
                                    Text("Graphics")
                                }
                                .padding(.leading, 7)
                                
                                VStack {
                                    ZStack {
                                        Circle()
                                            .trim(from: 0, to: 0.96)
                                            .stroke(Color(hex: "#FF6E57"), style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
                                            .frame(width: 80, height: 80)
                                            .rotationEffect(.degrees(-90))
                                        
                                        Text("96%")
                                    }
                                    
                                    Text("Mechanics")
                                }
                            }
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(0..<4) { _ in
                                        VStack(alignment: .leading) {
                                            VStack(alignment: .leading) {
                                                Text("Game Informer")
                                                
                                                Text("Matt Bertz")
                                                    .opacity(0.6)
                                            }
                                            
                                            Divider()
                                                .padding(.vertical)
                                            
                                            Text("10")
                                                .padding(.bottom, 8)
                                            
                                            Text("Rockstar has once again created a game that redefines the open-world experience. Red Dead Redemption II is a triumph that every gamer should experience for themselves")
                                                .opacity(0.6)
                                            
                                            Spacer()
                                        }
                                        .padding()
                                        .frame(width: 338, height: 336)
                                        .background(Color(hex: "#262626"))
                                        .padding(.horizontal, 6)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
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
    
    private func deleteWish(offsets: IndexSet) {
        withAnimation {
            offsets.map { wish[$0] }.forEach(PersistenceController.shared.container.viewContext.delete)
            
            try? PersistenceController.shared.container.viewContext.save()
        }
    }
    
    private func deleteOwned(offsets: IndexSet) {
        withAnimation {
            offsets.map { owned[$0] }.forEach(PersistenceController.shared.container.viewContext.delete)
            
            try? PersistenceController.shared.container.viewContext.save()
        }
    }
}

#Preview {
    ZStack {
        Circle()
            .trim(from: 0, to: 0.85)
            .stroke(Color(hex: "#FF6E57"), style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
            .frame(width: 80, height: 80)
            .rotationEffect(.degrees(-90))
        
        Text("94%")
    }
}
