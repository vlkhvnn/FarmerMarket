import SwiftUI

struct AddProductView: View {
    @Binding var products: [Product]

    @State private var name: String = ""
    @State private var description: String = ""
    @State private var price: String = ""
    @State private var quantity: String = ""
    @State private var category: String = "Vegetables"
    @State private var image: String = ""
    @State private var isLoading: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""

    let categories = ["Vegetables", "Fruits", "Bread", "Dairy"]
    let farmerId = APIService.userId

    var isFormValid: Bool {
        !name.isEmpty && !description.isEmpty && !price.isEmpty && !quantity.isEmpty
    }

    var body: some View {
        Form {
            Section(header: Text("Product Details")) {
                TextField("Name", text: $name)
                    .autocapitalization(.none)
                TextField("Description", text: $description)
                    .autocapitalization(.none)
                Picker("Category", selection: $category) {
                    ForEach(categories, id: \.self) { category in
                        Text(category)
                    }
                }
                TextField("Price (₸)", text: $price)
                    .keyboardType(.decimalPad)
                TextField("Quantity", text: $quantity)
                    .keyboardType(.numberPad)
                TextField("Image Name", text: $image)
                    .autocapitalization(.none)
            }

            Button(action: addProduct) {
                if isLoading {
                    ProgressView()
                } else {
                    Text("Add Product")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(isFormValid ? Color.green : Color.gray)
                        .cornerRadius(10)
                }
            }
            .disabled(!isFormValid || isLoading)
        }
        .navigationTitle("Add Product")
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Add Product"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }

    private func addProduct() {
        guard let priceValue = Float(price), let quantityValue = Int(quantity) else {
            alertMessage = "Invalid price or quantity"
            showAlert = true
            return
        }

        isLoading = true

        APIService.shared.addProduct(
            farmerId: farmerId,
            name: name,
            description: description,
            price: priceValue,
            quantity: quantityValue,
            category: category,
            image: image
        ) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let product):
                    products.append(product)
                    alertMessage = "Product added successfully!"
                case .failure(let error):
                    alertMessage = "Failed to add product: \(error.localizedDescription)"
                }
                showAlert = true
            }
        }
    }
}
