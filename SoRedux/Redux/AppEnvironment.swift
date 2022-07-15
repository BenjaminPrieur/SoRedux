import Foundation

struct AppEnvironment {
  var userEnvironment = UserEnvironment()
  var fixtureEnvironment = FixtureEnvironment()
}

struct UserEnvironment {
  var userService = UserService()
}

struct FixtureEnvironment {
  var fixtureService = FixtureService()
}
