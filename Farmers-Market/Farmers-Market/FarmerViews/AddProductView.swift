import SwiftUI

struct AddProductView: View {
    @Binding var products: [Product]

    @State private var name: String = ""
    @State private var description: String = ""
    @State private var price: String = ""
    @State private var quantity: String = ""
    @State private var category: String = "Vegetables"
    @State private var image: String = ""

    let categories = ["Vegetables", "Fruits", "Seeds"]

    var isFormValid: Bool {
        !name.isEmpty && !description.isEmpty && !price.isEmpty && !quantity.isEmpty
    }

    var body: some View {
        Form {
            Section(header: Text("Product Details")) {
                TextField("Name", text: $name)
                TextField("Description", text: $description)
                Picker("Category", selection: $category) {
                    ForEach(categories, id: \.self) { category in
                        Text(category)
                    }
                }
                TextField("Price (₸)", text: $price)
                    .keyboardType(.decimalPad)
                TextField("Quantity", text: $quantity)
                    .keyboardType(.numberPad)
                TextField("Image URL", text: $image)
            }

            Button(action: addProduct) {
                Text("Add Product")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(isFormValid ? Color.green : Color.gray)
                    .cornerRadius(10)
            }
            .disabled(!isFormValid)
        }
        .navigationTitle("Add Product")
    }

    private func addProduct() {
        guard let priceValue = Float(price), let quantityValue = Int(quantity) else { return }

        let newProduct = Product(
            id: UUID().uuidString,
            name: name,
            description: description,
            price: priceValue,
            quantity: quantityValue,
            category: category,
            image: image,
            farmerId: "1", // This should come from the logged-in farmer
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
            isOutOfStock: quantityValue == 0,
            createdAt: Date(),
            updatedAt: Date()
        )

        products.append(newProduct)
    }
}
