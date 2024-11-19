import SwiftUI

struct RegistrationSelectionView: View {
    var body: some View {
        VStack(spacing: 30) {
            Text("Register as")
                .font(.title)
                .fontWeight(.bold)

            NavigationLink(destination: FarmerRegistrationView()) {
                Text("Farmer")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
            }

            NavigationLink(destination: BuyerRegistrationView(isRegistered: .constant(false))) {
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
