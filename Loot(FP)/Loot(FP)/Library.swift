
import SwiftUI

struct Library: View {
    
    @State var selection = 0
    
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
                        .fill(Color("purple"))
                        .frame(width: width * 0.5, height: 5)
                        
                    if selection == 0 { Spacer() }
                }
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                }
            }
        }

    }
}

#Preview {
    Library()
        .preferredColorScheme(.dark)
}
