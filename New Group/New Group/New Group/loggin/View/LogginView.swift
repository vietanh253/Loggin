import SwiftUI
import GoogleSignIn
import FirebaseAuth
import FirebaseCore

struct LogginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isSignUp: Bool = false

    var body: some View {
        VStack(spacing: 16) {
            VStack(spacing: 8) {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Welcome")
                    .font(.headline)
                    .bold()
                Text("Enter your account here")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.top)

            VStack(alignment: .leading, spacing: 4) {
                Text("Email")
                    .font(.caption)
                HStack {
                    Image(systemName: "envelope")
                        .foregroundColor(.gray.opacity(0.3))
                    TextField("Email", text: $email)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                }
                .padding()
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
            }

            VStack(alignment: .leading, spacing: 4) {
                Text("Password")
                    .font(.caption)
                HStack {
                    Image(systemName: "lock")
                        .foregroundColor(.gray.opacity(0.3))
                    SecureField("Password", text: $password)
                }
                .padding()
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
            }

            HStack {
                Spacer()
                Button(action: {}) {
                    Text("Forgot password?")
                        .font(.footnote)
                        .foregroundColor(.red)
                        .bold()
                }
            }

            Button(action: {}) {
                Text("SIGN IN")
                    .font(.caption2)
                    .bold()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: 40)
                    .background(Color.red.opacity(0.3))
                    .cornerRadius(5)
            }

            HStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 1)
                Text("Or Sign In With")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 8)
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 1)
            }

            HStack(spacing: 16) {
                Button(action: {
                    signInWithGoogle()
                }) {
                    Image(systemName: "g.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.black)
                        .frame(width: 50, height: 50)
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                }

                Button(action: {}) {
                    Image(systemName: "f.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.blue)
                        .frame(width: 50, height: 50)
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                }
            }

            HStack(spacing: 4) {
                Text("Don't have an account?")
                    .font(.footnote)
                    .foregroundColor(.gray)
                Button(action: {
                    isSignUp = true
                }) {
                    Text("Sign up")
                        .font(.footnote)
                        .foregroundColor(.red)
                        .bold()
                }
                .navigationDestination(isPresented: $isSignUp) {
                                     SignUpView()
                                 }
            }
            .padding(.top, 8)

            Spacer()
        }
        .padding(.horizontal)
    }
}

func signInWithGoogle() {
    guard let clientID = FirebaseApp.app()?.options.clientID else { return }

    let config = GIDConfiguration(clientID: clientID)
    GIDSignIn.sharedInstance.configuration = config

    guard let presentingVC = UIApplication.shared.topViewController() else { return }

    GIDSignIn.sharedInstance.signIn(withPresenting: presentingVC) { result, error in
        if let error = error {
            print("Google Sign-In Error: \(error.localizedDescription)")
            return
        }

        guard let user = result?.user,
              let idToken = user.idToken?.tokenString else {
            print("Missing ID token")
            return
        }

        let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                       accessToken: user.accessToken.tokenString)

        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                print("Firebase Sign-In Error: \(error.localizedDescription)")
            } else {
                print("Signed in as \(authResult?.user.email ?? "Unknown")")
            }
        }
    }
}

#Preview {
    LogginView()
}
