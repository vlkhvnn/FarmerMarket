import SwiftUI

struct CategoriesView: View {
    @State private var selectedCategory: String = "All"

    let categories = ["All", "Vegetables", "Fruits", "Bakery", "Dairy"]
    let products = Array(repeating: Product(name: "Organic Bananas", details: "7pcs, Price Available: 10", price: "1000 ₸/kg"), count: 3)

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Categories Tabs
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(categories, id: \.self) { category in
                            Text(category)
                                .padding()
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
                        ForEach(products, id: \.self) { product in
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

struct Product: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let details: String
    let price: String
}

struct CategoryProductCard: View {
    let product: Product

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .frame(height: 100)
                .cornerRadius(10)
            Text(product.name)
                .font(.subheadline)
                .fontWeight(.medium)
            Text(product.details)
                .font(.footnote)
                .foregroundColor(.gray)
            HStack {
                Text(product.price)
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
