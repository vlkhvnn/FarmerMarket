import SwiftUI

struct OrderHistoryView: View {
    @EnvironmentObject var orderService: OrderService

    var body: some View {
        NavigationStack {
            Group {
                if orderService.isLoading {
                    ProgressView("Fetching your orders...")
                        .padding()
                } else if let error = orderService.errorMessage {
                    VStack {
                        Text("Failed to load orders")
                            .font(.headline)
                            .foregroundColor(.red)
                        Text(error)
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .padding()
                        Button(action: {
                            orderService.fetchOrderHistory()
                        }) {
                            Text("Retry")
                                .foregroundColor(.green)
                        }
                        .padding(.top, 10)
                    }
                    .padding()
                } else if orderService.orders.isEmpty {
                    VStack {
                        Text("No orders found.")
                            .font(.headline)
                            .foregroundColor(.gray)
                        Text("Looks like you haven't placed any orders yet.")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                    .padding()
                } else {
                    List {
                        ForEach(orderService.orders) { order in
                            NavigationLink(destination: OrderDetailView(order: order)) {
                                OrderRowView(order: order)
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Order History")
            .onAppear {
                orderService.fetchOrderHistory()
            }
        }
    }
}
