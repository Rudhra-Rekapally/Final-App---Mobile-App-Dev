import SwiftUI
import ActivityIndicatorView
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var selection = 1
    
    @StateObject var data = DataManager()

    var body: some View {
        NavigationView {
            ZStack {
                
                Group {
                    switch selection {
                    case 0:
                        Search()
                            .environmentObject(data)
                    case 1:
                        Home(selection: $selection)
                    case 2:
                        Library()
                            .environment(\.managedObjectContext, viewContext)
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
                            print("clicked magnifying")
//                            withAnimation { 
                            DispatchQueue.main.async {
                                selection = 0
                            }
//                            }
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(selection == 0 ? .accent : .white)
                                .frame(width: 30, height: 30)
                        }
                        
                        Spacer()
                        
                        Button {
                            print("clicked house")
//                            withAnimation { 
                            DispatchQueue.main.async {
                                selection = 1
                            }
//                            }
                        } label: {
                            Image(systemName: "house.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(selection == 1 ? .accent : .white)
                                .frame(width: 30, height: 30)
                        }
                        
                        Spacer()
                        
                        Button {
                            print("clicked book")
//                            withAnimation {
                            DispatchQueue.main.async {
                                selection = 2
                            }
//                            }
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
                
                ZStack {
                    Color("bg")
                        .ignoresSafeArea()
                    
                    ProgressView()
                }
                .zIndex(999)
                .frame(height: data.loading ? nil : 0)
                .opacity(data.loading ? 1 : 0)
            }
        }
        .task(data.fetch)
    }
}

func unique<S : Sequence, T : Hashable>(source: S) -> [T] where S.Iterator.Element == T {
    var buffer = [T]()
    var added = Set<T>()
    for elem in source {
        if !added.contains(elem) {
            buffer.append(elem)
            added.insert(elem)
        }
    }
    return buffer
}
