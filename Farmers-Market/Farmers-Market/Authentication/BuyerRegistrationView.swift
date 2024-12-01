import SwiftUI

struct BuyerRegistrationView: View {
    @Binding var role: Role
    @Binding var isRegistered: Bool
    @State private var fullName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var paymentMethod: String = ""
    @State private var address: String = ""
    @State private var phoneNumber: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var isLoading: Bool = false
    @State private var registrationError: String?

    var isRegisterEnabled: Bool {
        !fullName.isEmpty &&
        !email.isEmpty &&
        !password.isEmpty &&
        password == confirmPassword &&
        !paymentMethod.isEmpty &&
        !address.isEmpty &&
        !phoneNumber.isEmpty
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Full Name Field
                VStack(alignment: .leading, spacing: 8) {
                    Text("Full Name")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    TextField("Enter your full name", text: $fullName)
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(10)
                        .disableAutocorrection(true)
                        .autocapitalization(.words)
                }
                .padding(.horizontal)

                // Email Field
                VStack(alignment: .leading, spacing: 8) {
                    Text("Email")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    TextField("Enter your email", text: $email)
                        .keyboardType(.emailAddress)
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(10)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                }
                .padding(.horizontal)

                // Password Field
                VStack(alignment: .leading, spacing: 8) {
                    Text("Password")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    HStack {
                        if isPasswordVisible {
                            TextField("Enter your password", text: $password)
                        } else {
                            SecureField("Enter your password", text: $password)
                        }
                        Button(action: {
                            isPasswordVisible.toggle()
                        }) {
                            Image(systemName: isPasswordVisible ? "eye" : "eye.slash")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                }
                .padding(.horizontal)

                // Confirm Password Field
                VStack(alignment: .leading, spacing: 8) {
                    Text("Confirm Password")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    SecureField("Re-enter your password", text: $confirmPassword)
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(10)
                }
                .padding(.horizontal)

                // Payment Method Field
                VStack(alignment: .leading, spacing: 8) {
                    Text("Payment Method")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    TextField("Enter payment method", text: $paymentMethod)
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(10)
                        .disableAutocorrection(true)
                }
                .padding(.horizontal)

                // Address Field
                VStack(alignment: .leading, spacing: 8) {
                    Text("Address")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    TextField("Enter your address", text: $address)
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(10)
                        .disableAutocorrection(true)
                }
                .padding(.horizontal)

                // Phone Number Field
                VStack(alignment: .leading, spacing: 8) {
                    Text("Phone Number")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    TextField("Enter your phone number", text: $phoneNumber)
                        .keyboardType(.phonePad)
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(10)
                        .disableAutocorrection(true)
                }
                .padding(.horizontal)

                // Register Button
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
                        Text("Register")
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
            .padding(.top)
        }
        .navigationTitle("Register as Buyer")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func handleRegistration() {
        isLoading = true
        registrationError = nil

        let nameComponents = fullName.split(separator: " ")
        let firstName = nameComponents.first?.description ?? ""
        let lastName = nameComponents.dropFirst().joined(separator: " ")

        APIService.shared.buyerRegister(
            email: email,
            password: password,
            firstName: firstName,
            lastName: lastName,
            paymentMethod: paymentMethod,
            address: address,
            phoneNumber: phoneNumber
        ) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success:
                    isRegistered = true
                    role = .buyer
                case .failure(let error):
                    registrationError = error.localizedDescription
                }
            }
        }
    }
}
