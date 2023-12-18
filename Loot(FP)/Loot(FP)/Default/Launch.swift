
import SwiftUI

struct Launch: View {
    @Binding var showHome: Bool
    var body: some View {
        ZStack {
            
            Color.bg
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: width * 0.6, height: width * 0.6)
                
                Spacer()
                
                Button {
                    showHome.toggle()
                } label: {
                    Text("Continue")
                        .foregroundStyle(.bg)
                        .frame(width: width * 0.9, height: 55)
                        .background(Color.accentColor.cornerRadius(10))
                }
                
                Spacer()
            }
        }
    }
}

