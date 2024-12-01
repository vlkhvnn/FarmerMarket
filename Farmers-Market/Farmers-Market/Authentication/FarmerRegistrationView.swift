import SwiftUI

struct FarmerRegistrationView: View {
    @Binding var isRegistered: Bool
    @Binding var role: Role // Track the selected role
    @State private var chosenRole: Role = .none // Track user's role selection
    @State private var fullName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var phone: String = ""
    @State private var farmName: String = ""
    @State private var location: String = ""
    @State private var size: String = ""
    @State private var description: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var isLoading: Bool = false
    @State private var registrationError: String?

    var isRegisterEnabled: Bool {
        !fullName.isEmpty &&
        !email.isEmpty &&
        !password.isEmpty &&
        password == confirmPassword &&
        !phone.isEmpty &&
        !farmName.isEmpty &&
        !location.isEmpty &&
        !size.isEmpty &&
        !description.isEmpty
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                TextField("Full Name", text: $fullName)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)

                // Email Field
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)

                // Password Field
                VStack(alignment: .leading) {
                    HStack {
                        if isPasswordVisible {
                            TextField("Password", text: $password)
                        } else {
                            SecureField("Password", text: $password)
                        }
                        Button(action: { isPasswordVisible.toggle() }) {
                            Image(systemName: isPasswordVisible ? "eye" : "eye.slash")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)

                    SecureField("Confirm Password", text: $confirmPassword)
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(10)
                }
                .padding(.horizontal)

                // Phone Field
                TextField("Phone", text: $phone)
                    .keyboardType(.phonePad)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)

                // Farm Name Field
                TextField("Farm Name", text: $farmName)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)

                // Location Field
                TextField("Location", text: $location)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)

                // Farm Size Field
                TextField("Size (e.g., in acres)", text: $size)
                    .keyboardType(.decimalPad)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)

                // Description Field
                TextField("Description", text: $description)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)

                // Submit Button
                Button(action: {
                    handleRegistration()
                }) {
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                    } else {
                        Text("Submit")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(isRegisterEnabled ? Color.green : Color.green.opacity(0.5))
                            .cornerRadius(10)
                    }
                }
                .disabled(!isRegisterEnabled || isLoading)
                .padding(.horizontal)

                if let registrationError = registrationError {
                    Text(registrationError)
                        .foregroundColor(.red)
                        .font(.footnote)
                        .padding(.horizontal)
                }
            }
            .padding()
        }
        .navigationTitle("Farmer Registration")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func handleRegistration() {
        isLoading = true
        registrationError = nil

        let nameComponents = fullName.split(separator: " ")
        let firstName = nameComponents.first?.description ?? ""
        let lastName = nameComponents.dropFirst().joined(separator: " ")
        guard let farmSize = Int(size) else {
            registrationError = "Invalid farm size"
            isLoading = false
            return
        }

        APIService.shared.farmerRegister(
            email: email,
            password: password,
            firstName: firstName,
            lastName: lastName,
            farmName: farmName,
            farmAddress: location,
            farmSize: farmSize,
            phoneNumber: phone
        ) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success:
                    isRegistered = true
                    role = .farmer
                case .failure(let error):
                    registrationError = error.localizedDescription
                }
            }
        }
    }
}
