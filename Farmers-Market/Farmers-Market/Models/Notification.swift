import Foundation

struct Notification: Identifiable {

    var id: String
    var farmerId: String
    var farmer: Farmer
    var message: String
    var isRead: Bool
    var createdAt: Date
}
