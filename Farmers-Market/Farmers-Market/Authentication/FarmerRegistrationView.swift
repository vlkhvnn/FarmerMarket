import SwiftUI

struct FarmerRegistrationView: View {
    @State private var fullName: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""
    @State private var farmName: String = ""
    @State private var location: String = ""
    @State private var size: String = ""
    @State private var description: String = ""
    @State private var isSubmitted: Bool = false

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Farmer Registration")
                    .font(.title)
                    .fontWeight(.bold)

                TextField("Full Name", text: $fullName)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)

                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)

                TextField("Phone", text: $phone)
                    .keyboardType(.phonePad)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)

                TextField("Farm Name", text: $farmName)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)

                TextField("Location", text: $location)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)

                TextField("Size (e.g., in acres)", text: $size)
                    .keyboardType(.decimalPad)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)

                TextField("Description", text: $description)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)

                Button(action: {
                    isSubmitted = true
                }) {
                    Text("Submit")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                }

                if isSubmitted {
                    Text("Your registration is under review.")
                        .foregroundColor(.gray)
                        .font(.footnote)
                }
            }
            .padding()
        }
    }
}
