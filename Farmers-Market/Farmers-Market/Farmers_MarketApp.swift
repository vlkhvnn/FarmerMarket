import SwiftUI

@main
struct Farmers_MarketApp: App {
    @State private var role: Role = .none
    var body: some Scene {
        WindowGroup {
            switch role {
            case .none:
                LoginView(role: $role)
            case .farmer:
                FarmerDashboardView(role: $role)
            case .buyer:
                MainView(role: $role)
            }
        }
    }
}
