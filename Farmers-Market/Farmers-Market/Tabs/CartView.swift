import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartService: CartService
    @State private var showCheckoutAlert: Bool = false
    @State private var navigateToCheckout: Bool = false

    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 16) {
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(cartService.cartItems) { cartItem in
                                CartItemView(cartItem: cartItem)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                VStack {
                    Spacer()
                    Button(action: {
                        // Trigger checkout action
                        showCheckoutAlert = true
                    }) {
                        HStack {
                            Image(systemName: "cart")
                            Text("Go to Checkout")
                                .font(.headline)
                        }
                        .foregroundColor(.white)
                        .frame(height: 56)
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(10)
                    }
                }
                .padding()
            }
            .navigationTitle("Your Cart")
            .alert(isPresented: $showCheckoutAlert) {
                Alert(
                    title: Text("Proceed to Checkout"),
                    message: Text("Do you confirm your order?"),
                    primaryButton: .default(Text("Yes")) {
                        performCheckout()
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    }

    private func performCheckout() {
        let products = cartService.cartItems.map { ProductQuantity(productId: $0.product.id, quantity: $0.quantity) }
        let orderRequest = ConfirmOrderRequest(buyerId: APIService.userId, products: products)
        
        APIService.shared.confirmOrder(request: orderRequest) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let confirmOrderResponse):
                    cartService.cartItems.removeAll()
                    print(confirmOrderResponse)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }

        print("Checkout completed successfully!")
    }
}
