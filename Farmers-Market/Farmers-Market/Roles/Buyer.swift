import Foundation

struct Buyer: Hashable, Decodable {
    var id: String
    var email: String
    var firstName: String
    var lastName:  String
    var paymentMethod: String
    var address: String
    var phoneNumber: String
}
