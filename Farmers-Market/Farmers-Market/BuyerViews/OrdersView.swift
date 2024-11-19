import SwiftUI

struct OrdersView: View {
    let orders = [
        Order(orderNumber: "11111", images: ["bananas", "apples", "tomatoes"]),
        Order(orderNumber: "11111", images: ["tomatoes", "bananas", "oranges"])
    ]

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Orders List
                List {
                    ForEach(orders) { order in
                        OrderItemRow(order: order)
                    }
                }
                .listStyle(PlainListStyle())

                // View Cart Button
                Button(action: {
                    // View Cart Action
                }) {
                    HStack {
                        Image(systemName: "cart")
                        Text("View Cart (3)")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(10)
                }
                .padding(.horizontal)
            }
            .navigationBarTitle("Orders", displayMode: .inline)
        }
    }
}

struct OrderItemRow: View {
    let order: Order

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Order № \(order.orderNumber)")
                .font(.subheadline)
                .fontWeight(.medium)

            // Order Images
            HStack {
                ForEach(order.images, id: \.self) { imageName in
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .cornerRadius(8)
                }
            }

            HStack {
                Text("View details")
                    .font(.footnote)
                    .foregroundColor(.gray)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 8)
    }
}

struct Order: Identifiable {
    let id = UUID()
    let orderNumber: String
    let images: [String]
}

struct OrdersView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersView()
    }
}
