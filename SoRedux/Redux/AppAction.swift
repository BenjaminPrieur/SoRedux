import Foundation

enum AppAction {
  case user(action: UserAction)
  case fixture(action: FixtureAction)
}

enum UserAction {
  case auth(email: String, password: String)
  case setCurrentUser(user: User?)
}

enum FixtureAction {
  case loadFeatured
}
