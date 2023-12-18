import SwiftUI

struct Filter: View {
    
    @EnvironmentObject var data: DataManager
    
    @Environment(\.dismiss) var dismiss
    
    
    
    var body: some View {
        NavigationView {
            ZStack {
                
                Color("bg")
                    .ignoresSafeArea()
                
                VStack {
                    Text("Sort and Filter")
                        .font(.system(size: 25, weight: .bold))
                        .padding(.top)
                    
                    ScrollView {
                        VStack {
                            Text("Sort")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 20, weight: .bold))
                                .padding(.top)
                            
                            ForEach(FilterType.allCases) { f in
                                Button {
                                    withAnimation {
                                        if let i = data.filters.firstIndex(of: f) {
                                            data.filters.remove(at: i)
                                        } else {
                                            data.filters.append(f)
                                        }
                                    }
                                } label: {
                                    HStack {
                                        
                                        Image(f.rawValue)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 32, height: 32)
                                        
                                        Text(f.rawValue)
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundColor(.white)
                                            .padding(.leading, 4)
                                        
                                        Spacer()
                                        
                                        Image("check")
                                            .resizable()
                                            .renderingMode(.template)
                                            .foregroundColor(data.filters.contains(f) ? .accent : .gray)
                                            .scaledToFit()
                                            .frame(width: 24, height: 24)
                                    }
                                    .padding(.vertical)
                                }
                            }
                            
                            Text("Price Range")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 20, weight: .bold))
                                .padding(.top)
                            
                            HStack {
                                ForEach(PriceLevel.allCases) { p in
                                    Spacer()
                                    Button {
                                        withAnimation {
                                            if p == data.pricePoints {
                                                data.pricePoints = nil
                                            } else {
                                                data.pricePoints = p
                                            }
                                        }
                                    } label: {
                                        ZStack {
                                            Circle()
                                                .fill(data.pricePoints == p ? Color.accentColor : Color("purple_color"))
                                                .frame(width: 55, height: 55)
                                            
                                            Text(p.rawValue)
                                                .foregroundStyle(.white)
                                        }
                                    }
                                    Spacer()
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                }
            }
            .toolbar {
                Button("Done") {
                    dismiss()
                }
                .font(.body.bold())
            }
        }
    }
}

#Preview {
    Filter()
        .environmentObject(DataManager())
        .preferredColorScheme(.dark)
}

enum FilterType: String, Identifiable, CaseIterable {
    

    var id: String { rawValue }
    
    case mostPopular = "Most Popular"
    case recommended = "Recommended"
    case steamGames = "Steam Games"
    case epicGames = "Epic Games"
    case onSale = "On Sale"
    case freeToPlay = "Free To Play"
    case upcomingGames = "Upcoming Games"
}

enum PriceLevel: String, Identifiable, CaseIterable {
    
   
    var id: String { rawValue }
    
    case low = "$"
    case medium = "$$"
    case high = "$$$"
    case extraHigh = "$$$$"
    
    var range: ClosedRange<CGFloat> {
        switch self {
        case .low:
            return 0...3
        case .medium:
            return 3...20
        case .high:
            return 20...70
        case .extraHigh:
            return 70...1000
        }
    }
}
