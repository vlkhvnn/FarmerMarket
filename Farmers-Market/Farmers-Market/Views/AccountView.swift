import SwiftUI

struct AccountView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                HStack(spacing: 16) {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.black)

                    VStack(alignment: .leading, spacing: 4) {
                        Text("John Doe")
                            .font(.headline)
                        Text("johndoe@gmail.com")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }

                    Spacer()

                    Image(systemName: "pencil")
                        .foregroundColor(.green)
                }
                .padding(.horizontal)

                // Account Options List
                List {
                    AccountOptionRow(iconName: "cart", title: "Order History")
                    AccountOptionRow(iconName: "person", title: "My Details")
                    AccountOptionRow(iconName: "mappin.and.ellipse", title: "Delivery Address")
                    AccountOptionRow(iconName: "creditcard", title: "Payment Methods")
                    AccountOptionRow(iconName: "bell", title: "Notifications")
                    AccountOptionRow(iconName: "questionmark.circle", title: "Help")
                    AccountOptionRow(iconName: "info.circle", title: "About")
                }
                .listStyle(PlainListStyle())

                // Logout Button
                Button(action: {
                    // Logout action
                }) {
                    HStack {
                        Image(systemName: "arrowshape.turn.up.left")
                        Text("Logout")
                    }
                    .font(.headline)
                    .foregroundColor(.green)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green.opacity(0.2))
                    .cornerRadius(10)
                }
                .padding(.horizontal)

                Spacer()
            }
            .navigationBarTitle("Account", displayMode: .inline)
        }
    }
}

struct AccountOptionRow: View {
    let iconName: String
    let title: String

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: iconName)
                .foregroundColor(.black)
            Text(title)
                .font(.subheadline)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding(.vertical, 8)
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
