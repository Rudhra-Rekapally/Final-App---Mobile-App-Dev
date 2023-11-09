
import SwiftUI

struct Search: View {
    var body: some View {
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                Text("Explore")
                    .font(.system(size: 25, weight: .bold))
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        HStack {
                            
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.black)
                            
                            Text("Search")
                                .foregroundColor(.gray)
                            
                            Spacer()
                            
                            Image(systemName: "line.3.horizontal.decrease.circle")
                                .foregroundColor(.black)
                        }
                        .padding()
                        .frame(width: width * 0.9, height: 45)
                        .background(Color.white.cornerRadius(10))
                        
                        VStack {
                            
                            Text("Loot of the day")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.title)
                            
                            
                            HStack {
                                ScrollView(.horizontal) {
                                    
                                }
                            }
                            .padding(.top)
                        }
                        .padding()
                    }
                }
            }
        }
    }
}

#Preview {
    Search()
}
