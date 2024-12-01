import SwiftUI

struct ProductCard: View {
    let product: Product
    @EnvironmentObject var cartService: CartService
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(product.image)
                .resizable()
                .scaledToFit()
                .frame(height: 100)
                .cornerRadius(10)
            
            Text(product.name)
                .font(.subheadline)
                .fontWeight(.medium)
            
            Text(product.description)
                .font(.footnote)
                .foregroundColor(.gray)
            
            HStack {
                Text("₸\(product.price, specifier: "%.2f")")
                    .font(.footnote)
                    .fontWeight(.medium)
                    .foregroundColor(.green)
                
                Spacer()
                
                // Display Quantity if Product is in Cart
                if let cartItem = cartService.cartItems.first(where: { $0.product.id == product.id }) {
                    HStack(spacing: 4) {
                        Button(action: {
                            cartService.decreaseQuantity(cartItem.product)
                        }) {
                            Image(systemName: "minus.circle")
                                .foregroundColor(.green)
                        }
                        
                        Text("\(cartItem.quantity)")
                            .fontWeight(.medium)
                        
                        Button(action: {
                            cartService.increaseQuantity(cartItem.product)
                        }) {
                            Image(systemName: "plus.circle")
                                .foregroundColor(.green)
                        }
                    }
                } else {
                    // Add to Cart Button
                    Button(action: {
                        cartService.addToCart(item: product)
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .padding(8)
                            .background(Color.green)
                            .clipShape(Circle())
                    }
                }
            }
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(10)
    }
}
