import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Home")
                    .font(.largeTitle)
                    .padding()

                NavigationLink(destination: GamesView()) {
                    Text("Go to Games")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .navigationBarTitle("Home", displayMode: .inline)
        }
    }
}

struct GamesView: View {
    var body: some View {
        VStack {
            Text("Games")
                .font(.largeTitle)
                .padding()
        }
        .navigationBarTitle("Games", displayMode: .inline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
