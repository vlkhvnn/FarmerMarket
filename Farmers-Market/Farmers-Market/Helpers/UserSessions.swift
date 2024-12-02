import Foundation
import Combine

class UserSession: ObservableObject {
    @Published var buyerId: String? // Stores the buyer's ID
    @Published var buyer: Buyer? // Stores the Buyer object
    @Published var isLoggedIn: Bool = false // Indicates login status

    static let shared = UserSession() // Singleton instance
    
    static var userId = ""

    private init() {}
    
    /// Logs in the user by setting the buyerId and buyer details
    /// - Parameters:
    ///   - buyer: The Buyer object received from the API
    func logIn(buyer: Buyer) {
        self.buyerId = buyer.id
        self.buyer = buyer
        self.isLoggedIn = true
    }
    
    /// Logs out the user by clearing all session data
    func logOut() {
        self.buyerId = nil
        self.buyer = nil
        self.isLoggedIn = false
    }
}
