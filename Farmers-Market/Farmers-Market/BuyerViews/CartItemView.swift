import SwiftUI

struct CartItem: Identifiable {
    let id = UUID()
    var product: Product
    var quantity: Int
}

struct CartItemView: View {
    @EnvironmentObject var cartService: CartService
    let cartItem: CartItem

    var body: some View {
        HStack {
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .cornerRadius(8)

            VStack(alignment: .leading, spacing: 4) {
                Text(cartItem.product.name)
                    .font(.headline)
                    .lineLimit(1)
                Text("1kg, Price")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                HStack {
                    Button(action: {
                        cartService.decreaseQuantity(cartItem.product)
                    }) {
                        Image(systemName: "minus.circle")
                            .font(.title2)
                            .foregroundColor(.gray)
                    }
                    Text("\(cartItem.quantity)")
                        .font(.title2)
                        .frame(width: 40)
                    Button(action: {
                        cartService.increaseQuantity(cartItem.product)
                    }) {
                        Image(systemName: "plus.circle")
                            .font(.title2)
                            .foregroundColor(.green)
                    }
                }
            }

            Spacer()

            Text("\(Int(cartItem.product.price) * cartItem.quantity) ₸")
                .font(.headline)
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(10)
    }
}
