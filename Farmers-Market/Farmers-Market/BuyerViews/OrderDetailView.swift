import SwiftUI

struct OrderDetailView: View {
    let order: Order
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Order Summary
                VStack(alignment: .leading, spacing: 8) {
                    Text("Total Price: ₸\(order.totalPrice, specifier: "%.2f")")
                        .font(.headline)
                        .foregroundColor(.green)
                    Text("Placed At: \(convertAndFormat(dateString: order.createdAt) ?? "Unknown date")")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("Last Updated: \(convertAndFormat(dateString: order.updatedAt) ?? "Unknown date")")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(10)
                
                // Products List
                VStack(alignment: .leading, spacing: 8) {
                    Text("Products")
                        .font(.headline)
                    
                    ForEach(order.products, id: \.id) { productInOrder in
                        HStack(spacing: 16) {
                            Image(productInOrder.product.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                                .cornerRadius(8)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(productInOrder.product.name)
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                Text("Price: ₸\(productInOrder.product.price, specifier: "%.2f")")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                Text("Quantity: \(productInOrder.quantity)")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                        }
                        .padding(.vertical, 4)
                    }
                }
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(10)
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Order Details")
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
