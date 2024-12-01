import Foundation

struct Farmer: Identifiable, Decodable, Equatable {
    let id: String
    let email: String
    let firstName: String
    let lastName: String
    let farmName: String
    let farmAddress: String
    let farmSize: Int
    let phoneNumber: String
    let status: String
    let rejectionReason: String?
}

