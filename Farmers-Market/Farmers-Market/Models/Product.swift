import Foundation

struct Product: Identifiable, Equatable, Decodable {

    var id: String
    var name: String
    var description: String
    var price: Float
    var quantity: Int
    var category: String
    var image: String
    var farmerName: String
}
