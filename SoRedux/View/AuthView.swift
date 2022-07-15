import SwiftUI

struct AuthView: View {
  @EnvironmentObject var store: UserStore

  @State var email: String = "MyMail"
  @State var password: String = "MyPassword"

  var body: some View {
    VStack {
      TextField(text: $email) { Text("email") }
        .padding(6)
        .overlay { RoundedRectangle(cornerRadius: 4).stroke(.black, lineWidth: 2) }
      SecureField(text: $password) { Text("password") }
        .padding(6)
        .overlay { RoundedRectangle(cornerRadius: 4).stroke(.black, lineWidth: 2) }
      HStack {
        Button(action: auth) {
          Text("Send")
        }
        Spacer()
        Button(action: reset) {
          Text("Reset")
        }
      }
    }
    .debugAction {
      print("AuthView updated")
    }
  }

  private func auth() {
    store.send(.auth(email: email, password: password))
  }

  private func reset() {
    store.send(.setCurrentUser(user: nil))
  }
}
