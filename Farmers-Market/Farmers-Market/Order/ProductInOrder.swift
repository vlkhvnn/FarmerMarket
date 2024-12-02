import Foundation

struct OrderProductDetails: Decodable, Hashable {
    let id: String
    let name: String
    let description: String
    let price: Double
    let quantity: Int
    let category: String
    let image: String
    let farmerId: String
    let isOutOfStock: Bool
    let createdAt: Date
    let updatedAt: Date
}

struct ProductInOrder: Decodable, Hashable {
    let id: String
    let orderId: String
    let productId: String
    let quantity: Int
    let product: OrderProductDetails
}
