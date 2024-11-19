import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.green)
                            TextField("Search products...", text: .constant(""))
                                .padding(8)
                                .background(Color(UIColor.systemGray6))
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)

                        // Categories Section
                        Text("Categories")
                            .font(.headline)
                            .padding(.horizontal)

                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 10) {
                            CategoryCard(imageName: "apple", label: "Fruits")
                            CategoryCard(imageName: "carrot", label: "Vegetables")
                            CategoryCard(imageName: "milk", label: "Dairy")
                            CategoryCard(imageName: "bread", label: "Bakery")
                        }
                        .padding(.horizontal)

                        // Fresh Fruits Section
                        Text("Fresh Fruits")
                            .font(.headline)
                            .padding(.horizontal)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ProductCard(imageName: "apple", title: "Aport Apple", price: "1000 ₸/kg")
                                ProductCard(imageName: "orange", title: "Egypt Orange", price: "1200 ₸/kg")
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.vertical)
                }

                // Cart Button at the bottom
                Button(action: {
                    // Cart action
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
                .padding(.bottom, 10) // Add some padding to the bottom
            }
            .navigationTitle("Farmer's Market")
        }
    }
}

struct CategoryCard: View {
    let imageName: String
    let label: String

    var body: some View {
        VStack {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 80)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(10)
            Text(label)
                .font(.subheadline)
                .fontWeight(.medium)
        }
        .frame(maxWidth: .infinity)
    }
}

struct ProductCard: View {
    let imageName: String
    let title: String
    let price: String

    var body: some View {
        VStack(alignment: .leading) {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 100)
                .cornerRadius(10)
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
            Text(price)
                .font(.footnote)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(10)
        .frame(width: 150)
    }
}
