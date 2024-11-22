import Foundation

struct Farmer {
    var id: String
    var email: String
    var password: String
    var firstName: String
    var lastName: String
    var farmName: String
    var farmAddress: String
    var farmSize: Int
    var phoneNumber: String
    var status: String
    var rejectionReason: String?
    var products: [Product]
    var notifications: [Notification]
    var createdAt: Date
    var updatedAt: Date
}
