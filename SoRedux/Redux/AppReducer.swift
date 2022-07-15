import Foundation
import Combine

//typealias Reducer<State, Action> = (inout State, Action) -> Void
typealias Reducer<State, Action, Environment> = (inout State, Action, Environment) -> AnyPublisher<Action, Never>?

func appReducer(state: inout AppState, action: AppAction, environment: AppEnvironment) -> AnyPublisher<AppAction, Never> {
  switch action {
  case .user(action: let userAction):
    return userReducer(
      state: &state.userState,
      action: userAction,
      environment: environment.userEnvironment
    )
    .map(AppAction.user)
    .eraseToAnyPublisher()
  case .fixture(action: let fixtureAction):
    return fixtureReducer(
      state: &state.fixtureState,
      action: fixtureAction,
      environment: environment.fixtureEnvironment
    )
    .map(AppAction.fixture)
    .eraseToAnyPublisher()
  }
}

func userReducer(state: inout UserState, action: UserAction, environment: UserEnvironment) -> AnyPublisher<UserAction, Never> {
  switch action {
  case .auth(let email, let password):
    return environment.userService
      .auth(email: email, password: password)
      .map { $0 as? User } // convert to optional
      .replaceError(with: nil)
      .map { UserAction.setCurrentUser(user: $0) }
      .eraseToAnyPublisher()
  case .setCurrentUser(let user):
    state.currentUser = user
  }
  return Empty().eraseToAnyPublisher()
}

func fixtureReducer(state: inout FixtureState, action: FixtureAction, environment: FixtureEnvironment) -> AnyPublisher<FixtureAction, Never> {
  switch action {
  case .loadFeatured:
    state.featuredFixtures = [
      .init(id: "1", slug: "past"),
      .init(id: "2", slug: "live"),
      .init(id: "3", slug: "upcoming")
    ]
    return Empty().eraseToAnyPublisher()
  }
}
