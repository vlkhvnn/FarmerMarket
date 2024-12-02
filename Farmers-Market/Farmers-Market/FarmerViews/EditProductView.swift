import SwiftUI

struct EditProductView: View {
    @State var product: Product
    @Binding var products: [Product]
    @Environment(\.presentationMode) var presentationMode // To dismiss the view after saving
    @State private var isLoading: Bool = false
    @State private var errorMessage: String?

    var body: some View {
        Form {
            Section(header: Text("Product Details")) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Name")
                        .font(.headline)
                    TextField("Enter product name", text: $product.name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Description")
                        .font(.headline)
                    TextField("Enter product description", text: $product.description)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Category")
                        .font(.headline)
                    TextField("Enter product category", text: $product.category)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Price (₸)")
                        .font(.headline)
                    TextField("Enter price", value: $product.price, format: .number)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Quantity")
                        .font(.headline)
                    TextField("Enter quantity", value: $product.quantity, format: .number)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Image Name")
                        .font(.headline)
                    TextField("Enter image name", text: $product.image)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }

            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding()
            }

            Button(action: updateProduct) {
                if isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                        .padding()
                } else {
                    Text("Save Changes")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .disabled(isLoading)
        }
        .navigationTitle("Edit Product")
    }

    private func updateProduct() {
        isLoading = true
        errorMessage = nil

        // Prepare updated fields
        let updatedFields: [String: Any] = [
            "name": product.name,
            "description": product.description,
            "category": product.category,
            "price": product.price,
            "quantity": product.quantity,
            "image": product.image
        ]

        APIService.shared.updateProduct(productId: product.id, updatedFields: updatedFields) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let updatedProduct):
                    // Update the product in the list
                    if let index = products.firstIndex(where: { $0.id == updatedProduct.id }) {
                        products[index] = updatedProduct
                    }
                    presentationMode.wrappedValue.dismiss()
                case .failure(let error):
                    errorMessage = "Failed to update product: \(error.localizedDescription)"
                }
            }
        }
    }
}
