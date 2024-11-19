import SwiftUI

struct CategoriesView: View {
    @State private var selectedCategory: String = "All"

    let categories = ["All", "Vegetables", "Fruits", "Bakery", "Dairy"]
    let products = [
        Product(
            id: UUID().uuidString,
            name: "Organic Bananas",
            description: "7pcs, Price Available: 10",
            price: 1000.0,
            quantity: 20,
            category: "Fruits",
            image: "bananas",
            farmerId: "1",
            farmer: Farmer(
                id: "1",
                email: "farmer@example.com",
                password: "",
                firstName: "John",
                lastName: "Doe",
                farmName: "John's Farm",
                farmAddress: "123 Farm Lane",
                farmSize: 50,
                phoneNumber: "1234567890",
                status: "Approved",
                rejectionReason: nil,
                products: [],
                notifications: [],
                createdAt: Date(),
                updatedAt: Date()
            ),
            isOutOfStock: false,
            createdAt: Date(),
            updatedAt: Date()
        ),
        Product(
            id: UUID().uuidString,
            name: "Fresh Tomatoes",
            description: "1kg, Organic Produce",
            price: 500.0,
            quantity: 15,
            category: "Vegetables",
            image: "tomatoes",
            farmerId: "2",
            farmer: Farmer(
                id: "2",
                email: "farmer2@example.com",
                password: "",
                firstName: "Jane",
                lastName: "Doe",
                farmName: "Jane's Farm",
                farmAddress: "456 Rural Road",
                farmSize: 40,
                phoneNumber: "9876543210",
                status: "Approved",
                rejectionReason: nil,
                products: [],
                notifications: [],
                createdAt: Date(),
                updatedAt: Date()
            ),
            isOutOfStock: false,
            createdAt: Date(),
            updatedAt: Date()
        )
    ]

    var filteredProducts: [Product] {
        selectedCategory == "All" ? products : products.filter { $0.category == selectedCategory }
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Categories Tabs
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(categories, id: \.self) { category in
                            Text(category)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                                .background(selectedCategory == category ? Color.green.opacity(0.2) : Color.clear)
                                .cornerRadius(10)
                                .onTapGesture {
                                    selectedCategory = category
                                }
                        }
                    }
                    .padding(.horizontal)
                }

                // Products Grid
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 2), spacing: 20) {
                        ForEach(filteredProducts, id: \.id) { product in
                            CategoryProductCard(product: product)
                        }
                    }
                    .padding()
                }

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
            .navigationBarTitle("Categories", displayMode: .inline)
        }
    }
}

struct CategoryProductCard: View {
    let product: Product

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(product.image)
                .resizable()
                .scaledToFit()
                .frame(height: 100)
                .cornerRadius(10)
            Text(product.name)
                .font(.subheadline)
                .fontWeight(.medium)
            Text(product.description)
                .font(.footnote)
                .foregroundColor(.gray)
            HStack {
                Text("₸\(product.price, specifier: "%.2f")")
                    .font(.footnote)
                    .fontWeight(.medium)
                    .foregroundColor(.green)
                Spacer()
                Button(action: {
                    // Add to cart action
                }) {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .clipShape(Circle())
                }
            }
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(10)
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
    }
}
