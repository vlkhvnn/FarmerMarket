import SwiftUI

struct RegistrationSelectionView: View {
    @Binding var role: Role
    var body: some View {
        VStack(spacing: 30) {
            Text("Register as")
                .font(.title)
                .fontWeight(.bold)

            NavigationLink(destination: FarmerRegistrationView(isRegistered: .constant(false), role: $role)) {
                Text("Farmer")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
            }

            NavigationLink(destination: BuyerRegistrationView(role: $role, isRegistered: .constant(false))) {
                Text("Buyer")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }

        }
        .padding()
    }
}
