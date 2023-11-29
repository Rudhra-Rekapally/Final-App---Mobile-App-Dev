import Foundation
import SwiftUI

protocol Game: Identifiable, Hashable {
    var imageURL: String { get }
    var name: String { get }
    var rating: CGFloat { get }
    var price: CGFloat { get }
    var releaseD: Date { get }
    var developer: String? { get }
}
