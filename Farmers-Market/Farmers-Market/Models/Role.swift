import Foundation

enum Role: String, Hashable {
    case farmer = "Farmer"
    case buyer = "Buyer"
    case none = "None"

    var description: String {
        switch self {
        case .farmer: return "Farmer"
        case .buyer: return "Buyer"
        case .none: return "None"
        }
    }
}
