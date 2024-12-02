import Foundation

struct Order: Decodable, Identifiable {
    let id: String
    let buyerId: String
    let totalPrice: Double
    let status: String
    let createdAt: String // Use String if the API returns dates as strings
    let updatedAt: String
    let products: [OrderProduct]
}
