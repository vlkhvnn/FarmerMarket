import SwiftUI

struct HomeView: View {
    @State private var selectedCategory: String = "All"
    @State private var products: [Product] = [] // Products fetched from the API
    @State private var isLoading: Bool = true // Loading state
    @State private var errorMessage: String? = nil // Error message for API call
    @State private var searchQuery: String = "" // Search query input
    
    let categories = ["All", "Vegetables", "Fruits", "Bakery", "Dairy"]
    
    @EnvironmentObject var cartService: CartService
    
    var filteredProducts: [Product] {
        let filteredByCategory = selectedCategory == "All" ? products : products.filter { $0.category == selectedCategory }
        return searchQuery.isEmpty ? filteredByCategory : filteredByCategory.filter {
            $0.name.localizedCaseInsensitiveContains(searchQuery) ||
            $0.description.localizedCaseInsensitiveContains(searchQuery)
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 0) {
                    if isLoading {
                        ProgressView("Loading products...")
                            .padding()
                    } else if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    } else {
                        // Scrollable Content
                        ScrollView {
                            VStack(alignment: .leading, spacing: 20) {
                                // Search Bar
                                HStack {
                                    Image(systemName: "magnifyingglass")
                                        .foregroundColor(.green)
                                    TextField("Search products...", text: $searchQuery)
                                        .padding(8)
                                        .background(Color(UIColor.systemGray6))
                                        .cornerRadius(10)
                                }
                                .padding(.horizontal)
                                
                                // Category Selection
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
                                
                                // All Products Section
                                Text("All Products")
                                    .font(.headline)
                                    .padding(.horizontal)
                                
                                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                                    ForEach(filteredProducts) { product in
                                        NavigationLink(destination: ProductDetailView(product: product)) {
                                            ProductCard(product: product)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                    }
                                }
                                .padding(.horizontal)
                            }
                            .padding(.vertical)
                        }
                    }
                }
                
                // Fixed Cart Button at the bottom of the screen
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink(destination: CartView()) {
                            HStack {
                                Image(systemName: "cart")
                                Text("View Cart (\(cartService.totalQuantity()))")
                            }
                            .font(.headline)
                            .foregroundColor(.white)
                        }
                        .frame(height: 56) // Set button height
                        .frame(maxWidth: .infinity) // Make the button stretch horizontally
                        .background(Color.green)
                        .cornerRadius(10)
                        .padding(.horizontal, 16) // Horizontal padding
                        Spacer()
                    }
                    .padding(.bottom, 10)
                }
            }
            .navigationTitle("Farmer's Market")
            .navigationBarHidden(true)
            .onAppear(perform: fetchProducts) // Fetch products when view appears
        }
    }
    
    private func fetchProducts() {
        isLoading = true
        errorMessage = nil
        
        APIService.shared.getAllProducts { result in
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
}
