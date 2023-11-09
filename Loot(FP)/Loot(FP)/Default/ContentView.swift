
import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @State var selection = 1
    
    @StateObject var data = DataManager()

    var body: some View {
        NavigationView {
            ZStack {
                
                Group {
                    switch selection {
                    case 0:
                        FreeToPlayView()
                            .environmentObject(data)
                    case 1:
                        Home(selection: $selection)
                    case 2:
                        Library()
                    default:
                        Text("")
                    }
                }
                .environmentObject(data)
                
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Button {
                            withAnimation { selection = 0 }
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(selection == 0 ? .accent : .white)
                                .frame(width: 30, height: 30)
                        }
                        
                        Spacer()
                        
                        Button {
                            withAnimation { selection = 1 }
                        } label: {
                            Image(systemName: "house.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(selection == 1 ? .accent : .white)
                                .frame(width: 30, height: 30)
                        }
                        
                        Spacer()
                        
                        Button {
                            withAnimation { selection = 2 }
                        } label: {
                            Image(systemName: "book")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(selection == 2 ? .accent : .white)
                                .frame(width: 30, height: 30)
                        }
                        
                        Spacer()
                    }
                    .frame(width: width, height: 100)
                    .background(Color.black.cornerRadius(20, corners: [.topLeft, .topRight]))
                }
                .ignoresSafeArea()
            }
        }
        .onAppear(perform: data.fetch)
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
              
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        .preferredColorScheme(.dark)
}
