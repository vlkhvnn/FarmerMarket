import SwiftUI

struct FarmerDashboardView: View {
    @State private var products: [Product] = []
    @Binding var role: Role
    @State private var isLoading: Bool = false
    @State private var errorMessage: String?

    var body: some View {
        NavigationView {
            VStack {
                if isLoading {
                    ProgressView("Loading products...")
                        .padding()
                } else if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                } else {
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
                }

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
                leading: NavigationLink(destination: NotificationsView()) {
                    Image(systemName: "bell")
                        .foregroundColor(.blue)
                },
                trailing: Button(action: logout) {
                    Text("Logout")
                        .foregroundColor(.red)
                }
            )
            .onAppear(perform: fetchProducts)
        }
    }

    private func fetchProducts() {
        isLoading = true
        APIService.shared.fetchFarmerProducts { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let fetchedProducts):
                    products = fetchedProducts
                case .failure(let error):
                    errorMessage = "Failed to load products: \(error.localizedDescription)"
                }
            }
        }
    }

    private func deleteProduct(at offsets: IndexSet) {
        products.remove(atOffsets: offsets)
    }

    private func logout() {
        role = .none
    }
}
