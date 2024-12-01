import SwiftUI

struct LoginView: View {
    @Binding var role: Role
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var isLoading: Bool = false
    @State private var loginError: String?
    @State private var chosenRole: Role = .none

    var isLoginEnabled: Bool {
        !email.isEmpty && !password.isEmpty && chosenRole != .none
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Login")
                    .font(.title)
                    .fontWeight(.bold)

                // Role Selection
                Text("Select Role")
                    .font(.headline)
                HStack {
                    ForEach([Role.farmer, Role.buyer], id: \.self) { roleOption in
                        Button(action: {
                            chosenRole = roleOption
                        }) {
                            HStack {
                                Image(systemName: chosenRole == roleOption ? "largecircle.fill.circle" : "circle")
                                    .foregroundColor(.green)
                                Text(roleOption.description)
                            }
                        }
                        .padding(.horizontal)
                    }
                }

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
                        Image(systemName: isPasswordVisible ? "eye" : "eye.slash")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)

                // Login Button
                Button(action: handleLogin) {
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                    } else {
                        Text("Log In")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(isLoginEnabled ? Color.green : Color.green.opacity(0.5))
                            .cornerRadius(10)
                    }
                }
                .disabled(!isLoginEnabled || isLoading)
                .padding(.horizontal)

                if let loginError = loginError {
                    Text(loginError)
                        .foregroundColor(.red)
                        .font(.footnote)
                        .padding(.horizontal)
                }

                // Signup Option
                HStack {
                    Text("Don’t have an account?")
                    NavigationLink(destination: RegistrationSelectionView(role: $role)) {
                        Text("Signup")
                            .foregroundColor(.green)
                    }
                }

                Spacer()
            }
            .navigationBarHidden(true)
        }
    }

    private func handleLogin() {
        isLoading = true
        loginError = nil

        switch chosenRole {
        case .farmer:
            APIService.shared.farmerLogin(email: email, password: password) { result in
                isLoading = false
                handleFarmerLoginResponse(result: result, currRole: .farmer)
            }
        case .buyer:
            APIService.shared.buyerLogin(email: email, password: password) { result in
                isLoading = false
                handleBuyerLoginResponse(result: result, currRole: .buyer)
            }
        case .none:
            isLoading = false
            loginError = "Please select a role."
        }
    }

    private func handleBuyerLoginResponse(result: Result<Buyer, Error>, currRole: Role) {
        switch result {
        case .success:
            role = currRole
        case .failure(let error):
            print(error.localizedDescription)
        }
    }

    private func handleFarmerLoginResponse(result: Result<Farmer, Error>, currRole: Role) {
        switch result {
        case .success:
            role = currRole
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
