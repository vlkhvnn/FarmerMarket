import SwiftUI

@main
struct Farmers_MarketApp: App {
    @State private var role: Role = .none
    @StateObject private var orderService = OrderService()
    var body: some Scene {
        WindowGroup {
            switch role {
            case .none:
                LoginView(role: $role)
            case .farmer:
                FarmerDashboardView(role: $role)
            case .buyer:
                TabsView(role: $role)
                    .environmentObject(CartService())
                    .environmentObject(orderService)
            }
        }
    }
}
