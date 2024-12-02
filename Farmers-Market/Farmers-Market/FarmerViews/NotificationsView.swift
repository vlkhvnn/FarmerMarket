import SwiftUI

struct NotificationsView: View {
    @State private var notifications: [Notification] = []
    @State private var isLoading: Bool = false
    @State private var errorMessage: String?
    
    let farmerId = "cl1234abcd" // Replace with dynamic farmerId if needed
    
    var body: some View {
        NavigationView {
            VStack {
                if isLoading {
                    ProgressView("Loading notifications...")
                        .padding()
                } else if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                } else if notifications.isEmpty {
                    Text("No notifications found.")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List(notifications) { notification in
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(notification.message)
                                    .font(.headline)
                                Text(notification.createdAtFormatted)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            if !notification.isRead {
                                Circle()
                                    .fill(Color.blue)
                                    .frame(width: 10, height: 10)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Notifications")
            .onAppear(perform: fetchNotifications)
        }
    }
    
    private func fetchNotifications() {
        isLoading = true
        APIService.shared.fetchNotifications { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let fetchedNotifications):
                    notifications = fetchedNotifications
                case .failure(let error):
                    errorMessage = "Failed to load notifications: \(error.localizedDescription)"
                }
            }
        }
    }
}

extension Notification {
    var createdAtFormatted: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.locale = Locale.current
        guard let date = ISO8601DateFormatter().date(from: createdAt) else { return "Unknown Date" }
        return formatter.string(from: date)
    }
}
