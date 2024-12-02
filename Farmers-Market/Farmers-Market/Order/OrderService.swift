import Foundation
import Combine

class OrderService: ObservableObject {
    @Published var orders: [Order] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    /// Fetches the order history for the logged-in buyer.
    /// - Parameter buyerId: The ID of the buyer.
    func fetchOrderHistory() {
        self.isLoading = true
        self.errorMessage = nil
        
        APIService.shared.getOrderHistory { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let fetchedOrders):
                    self?.orders = fetchedOrders
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
