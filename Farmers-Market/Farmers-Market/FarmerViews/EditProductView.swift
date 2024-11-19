import SwiftUI

struct EditProductView: View {
    @State var product: Product
    @Binding var products: [Product]
    @Environment(\.presentationMode) var presentationMode // To dismiss the view after saving

    var body: some View {
        Form {
            Section(header: Text("Product Details")) {
                TextField("Name", text: $product.name)
                TextField("Description", text: $product.description)
                TextField("Category", text: $product.category)
                TextField("Price (₸)", value: $product.price, format: .number)
                    .keyboardType(.decimalPad)
                TextField("Quantity", value: $product.quantity, format: .number)
                    .keyboardType(.numberPad)
                TextField("Image URL", text: $product.image)
            }

            Button(action: {
                updateProduct()
            }) {
                Text("Save Changes")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .navigationTitle("Edit Product")
    }

    private func updateProduct() {
        // Find the index of the product in the products array
        if let index = products.firstIndex(where: { $0.id == product.id }) {
            products[index] = product
            products[index].updatedAt = Date() // Update the timestamp
        }

        // Dismiss the edit view
        presentationMode.wrappedValue.dismiss()
    }
}
