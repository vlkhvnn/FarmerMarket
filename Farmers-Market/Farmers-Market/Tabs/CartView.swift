import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartService: CartService

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                // Top Bar
                HStack {
                    Text("My cart")
                        .font(.title2)
                        .bold()
                    Spacer()
                    Image(systemName: "magnifyingglass")
                        .font(.title3)
                }
                .padding()

                // Cart Items List
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(cartService.cartItems) { cartItem in
                            CartItemView(cartItem: cartItem)
                        }
                    }
                    .padding(.horizontal)
                }

                Spacer()

                // Checkout Button
                HStack {
                    Text("\(String(format: "%.2f", cartService.totalAmount())) ₸")
                        .font(.headline)
                        .bold()
                        .foregroundColor(.white)

                    Spacer()

                    Button(action: {
                        // Checkout action
                    }) {
                        HStack {
                            Image(systemName: "cart")
                            Text("Go to checkout")
                                .font(.headline)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 16)
            }
        }
    }
}
