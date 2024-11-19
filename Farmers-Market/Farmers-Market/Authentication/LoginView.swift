import SwiftUI

struct LoginView: View {
    @Binding var role: String // Tracks the user's role ('farmer' or 'buyer')
    @Binding var isLoggedIn: Bool
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false

    var isLoginEnabled: Bool {
        !email.isEmpty && !password.isEmpty
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Login")
                    .font(.title)
                    .fontWeight(.bold)

                // Email Input
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding(.horizontal)

                // Password Input
                HStack {
                    if isPasswordVisible {
                        TextField("Password", text: $password)
                    } else {
                        SecureField("Password", text: $password)
                    }
                    Button(action: { isPasswordVisible.toggle() }) {
                        Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)

                // Login Button
                Button(action: {
                    // Mock role assignment based on email
                    if email == "farmer@example.com" {
                        role = "farmer"
                        isLoggedIn = true
                    } else if email == "buyer@example.com" {
                        role = "buyer"
                        isLoggedIn = true
                    }
                }) {
                    Text("Log In")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isLoginEnabled ? Color.green : Color.green.opacity(0.5))
                        .cornerRadius(10)
                }
                .disabled(!isLoginEnabled)
                .padding(.horizontal)

                // Signup Option
                HStack {
                    Text("Don’t have an account?")
                    NavigationLink(destination: RegistrationSelectionView()) {
                        Text("Signup")
                            .foregroundColor(.green)
                    }
                }

                Spacer()
            }
        }
        .navigationBarHidden(true)
    }
}
