import Foundation

struct Buyer: Hashable {
    var id: String
    var email: String
    var password: String
    var firstName: String
    var lastName:  String
    var paymentMethod: String
    var address: String
    var phoneNumber: String
    var createdAt: Date
    var updatedAt: Date
}
