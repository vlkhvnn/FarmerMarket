import Foundation

class CartService: ObservableObject {
    @Published var cartItems: [CartItem] = []
    
    private let cartKey = "cartItems"
    
    func getCartItems() -> [CartItem] {
        return cartItems
    }
    
    func addToCart(item: Product) {
        if let index = cartItems.firstIndex(where: { $0.product.id == item.id }) {
            cartItems[index].quantity += 1
        } else {
            cartItems.append(CartItem(product: item, quantity: 1))
        }
    }
    
    func removeFromCart(item: Product) {
        cartItems.removeAll { $0.product.id == item.id }
    }
    
    func increaseQuantity(_ item: Product) {
        if let index = cartItems.firstIndex(where: { $0.product.id == item.id }) {
            cartItems[index].quantity += 1
        }
    }
    
    func decreaseQuantity(_ item: Product) {
        if let index = cartItems.firstIndex(where: { $0.product.id == item.id }) {
            cartItems[index].quantity -= 1
            if cartItems[index].quantity <= 0 {
                removeFromCart(item: item)
            }
        }
    }
    
    func totalAmount() -> Double {
        return Double(cartItems.reduce(0) { $0 + ($1.product.price * Float($1.quantity)) })
    }
    
    func productTypeAmount() -> Int {
        cartItems.count
    }
    
    func totalQuantity() -> Int {
        return cartItems.reduce(0) { $0 + $1.quantity }
    }
}
