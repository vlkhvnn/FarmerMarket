import SwiftUI

struct OrderRowView: View {
    let order: Order
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(order.status.capitalized)
                    .font(.subheadline)
            }
            
            Text("Total: ₸\(order.totalPrice, specifier: "%.2f")")
                .font(.headline)
                .foregroundColor(.green)
            
            Text("Placed on \(convertAndFormat(dateString: order.createdAt) ?? "Unknown date")")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 8)
    }
    
    private func convertAndFormat(dateString: String) -> String? {
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        if let date = isoDateFormatter.date(from: dateString) {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            formatter.locale = Locale.current
            return formatter.string(from: date)
        } else {
            print("Invalid date string: \(dateString)")
            return nil
        }
    }
}

extension String {
    /// Returns a color based on the order status.
    var statusColor: Color {
        switch self.lowercased() {
        case "delivered":
            return .green
        case "pending":
            return .orange
        case "cancelled":
            return .red
        default:
            return .gray
        }
    }
}
