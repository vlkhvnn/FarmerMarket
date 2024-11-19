import SwiftUI

@main
struct Farmers_MarketApp: App {
    @State private var isLoggedIn: Bool = false
    @State private var role = ""
    var body: some Scene {
        WindowGroup {
                    if isLoggedIn {
                        MainView()
                    } else {
                        LoginView(role: $role, isLoggedIn: $isLoggedIn)
                    }
                }
    }
}
