import SwiftUI

struct FavoritesView: View {
    let favorites = [
        FavoriteProduct(name: "Aport apple", details: "1 kg", price: "1000 ₸/kg"),
        FavoriteProduct(name: "Egypt orange", details: "1 kg", price: "1000 ₸/kg"),
        FavoriteProduct(name: "Cherry tomato", details: "1 kg", price: "1000 ₸/kg"),
        FavoriteProduct(name: "Mirinda cucumber", details: "1 kg", price: "1000 ₸/kg")
    ]

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Favorites List
                List {
                    ForEach(favorites) { product in
                        FavoriteItemRow(product: product)
                    }
                }
                .listStyle(PlainListStyle())

                // View Cart Button
                Button(action: {
                    // View Cart Action
                }) {
                    HStack {
                        Image(systemName: "cart")
                        Text("View Cart (3)")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(10)
                }
                .padding(.horizontal)
            }
            .navigationBarTitle("Favorites", displayMode: .inline)
        }
    }
}

struct FavoriteItemRow: View {
    let product: FavoriteProduct

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .cornerRadius(8)
            VStack(alignment: .leading, spacing: 4) {
                Text(product.name)
                    .font(.subheadline)
                    .fontWeight(.medium)
                Text(product.details)
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            Spacer()
            VStack {
                Text(product.price)
                    .font(.footnote)
                    .foregroundColor(.green)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 8)
    }
}

struct FavoriteProduct: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let details: String
    let price: String
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
