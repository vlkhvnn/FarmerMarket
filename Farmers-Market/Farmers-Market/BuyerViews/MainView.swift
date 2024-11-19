import SwiftUI

struct MainView: View {
    @State private var selection = 0
    @Binding var role: Role
    
    var body: some View {
        TabView(selection: $selection) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)
            
            CategoriesView()
                .tabItem {
                    Label("Categories", systemImage: "magnifyingglass")
                }
                .tag(1)
            
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart.fill")
                }
                .tag(2)

            OrdersView()
                .tabItem {
                    Label("Orders", systemImage: "bag.fill")
                }
                .tag(3)

            AccountView(role: $role)
                .tabItem {
                    Label("Account", systemImage: "person.fill")
                }
                .tag(2)
        }
    }
}
