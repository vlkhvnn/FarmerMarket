import Foundation

struct Product {

    var id: String
    var name: String
    var description: String
    var price: Float
    var quantity: Int
    var category: String
    var image: String
    var farmerId: String
    var farmer: Farmer
    var isOutOfStock: Bool
    var createdAt: Date
    var updatedAt: Date
}
