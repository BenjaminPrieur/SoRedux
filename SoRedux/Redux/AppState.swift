import Foundation

struct AppState {
  var userState: UserState
  var fixtureState: FixtureState
}

struct UserState: Equatable {
  var currentUser: User?
}

struct FixtureState: Equatable {
  var featuredFixtures: [Fixture] = []
}
