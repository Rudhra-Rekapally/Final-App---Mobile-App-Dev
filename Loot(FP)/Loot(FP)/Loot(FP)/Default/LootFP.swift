import SwiftUI

@main
struct LootFP: App {
    let persistenceController = PersistenceController.shared
    
    @State var showHome = false

    var body: some Scene {
        WindowGroup {
            if showHome {
                ContentView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .preferredColorScheme(.dark)
            } else {
                Launch(showHome: $showHome)
            }
        }
    }
}
