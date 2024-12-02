import Foundation

struct Notification: Identifiable, Equatable, Decodable {
    var id: String
    var farmerId: String
    var message: String
    var isRead: Bool
    var createdAt: String
}
