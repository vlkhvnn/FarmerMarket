import SwiftUI

struct FarmerDashboardView: View {
    @State private var products: [Product] = [
        Product(
            id: UUID().uuidString,
            name: "Tomatoes",
            description: "Fresh organic tomatoes.",
            price: 200.0,
            quantity: 10,
            category: "Vegetables",
            image: "tomato",
            farmerId: "1",
            farmer: Farmer(
                id: "1",
                email: "farmer@example.com",
                password: "password123",
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
        )
    ]
    @Binding var role: Role

    var body: some View {
        NavigationView {
            VStack {
                // Dashboard Header
                Text("Farmer Dashboard")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()

                // Product List
                List {
                    ForEach(products, id: \.id) { product in
                        NavigationLink(destination: EditProductView(product: product, products: $products)) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(product.name)
                                        .font(.headline)
                                    Text("\(product.quantity) available")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                Text("₸\(product.price, specifier: "%.2f")")
                                    .font(.subheadline)
                                    .foregroundColor(.green)
                            }
                        }
                    }
                    .onDelete(perform: deleteProduct)
                }
                .listStyle(PlainListStyle())

                // Add Product Button
                NavigationLink(destination: AddProductView(products: $products)) {
                    Text("Add New Product")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            }
            .navigationBarTitle("Dashboard", displayMode: .inline)
            .navigationBarItems(
                trailing: Button(action: logout) {
                    Text("Logout")
                        .foregroundColor(.red)
                }
            )
        }
    }

    private func deleteProduct(at offsets: IndexSet) {
        products.remove(atOffsets: offsets)
    }

    private func logout() {
        role = .none
    }
}
