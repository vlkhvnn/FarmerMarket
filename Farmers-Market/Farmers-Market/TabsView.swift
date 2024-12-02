import SwiftUI

struct TabsView: View {
    @State private var selection = 0
    @Binding var role: Role
    @EnvironmentObject var cartManager: CartService // Access the CartManager

    var body: some View {
        TabView(selection: $selection) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)

            CartView()
                .tabItem {
                    Label("Cart", systemImage: "cart")
                }
                .tag(1)

            OrderHistoryView()
                .tabItem {
                    Label("Orders", systemImage: "bag.fill")
                }
                .tag(2)

            AccountView(role: $role)
                .tabItem {
                    Label("Account", systemImage: "person.fill")
                }
                .tag(3)
        }
    }
}
