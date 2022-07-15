import Foundation
import Combine

typealias AppStore = Store<AppState, AppAction, AppEnvironment>
typealias UserStore = Store<UserState, UserAction, UserEnvironment>
typealias FixtureStore = Store<FixtureState, FixtureAction, FixtureEnvironment>

final class Store<State, Action, Environment>: ObservableObject {
  @Published private(set) var state: State

  private let environment: Environment
  private let reducer: Reducer<State, Action, Environment>
  private var effectCancellables: Set<AnyCancellable> = []

  init(
    initialState: State,
    reducer: @escaping Reducer<State, Action, Environment>,
    environment: Environment
  ) {
    self.state = initialState
    self.reducer = reducer
    self.environment = environment
  }

  func send(_ action: Action) {
    guard let effect = reducer(&state, action, environment) else {
      return
    }

    effect
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: send)
      .store(in: &effectCancellables)
  }

  func derived<DerivedState: Equatable, ExtractedAction, DerivedEnvironment>(
    deriveState: @escaping (State) -> DerivedState,
    embedAction: @escaping (ExtractedAction) -> Action,
    deriveEnvironment: @escaping (Environment) -> DerivedEnvironment
  ) -> Store<DerivedState, ExtractedAction, DerivedEnvironment> {
    let reducer: Reducer<DerivedState, ExtractedAction, DerivedEnvironment> = { _, action, _ in
      self.send(embedAction(action))
      return Empty().eraseToAnyPublisher()
    }

    let store = Store<DerivedState, ExtractedAction, DerivedEnvironment>(
      initialState: deriveState(state),
      reducer: reducer,
      environment: deriveEnvironment(environment)
    )
    $state
      .map(deriveState)
      .removeDuplicates()
      .receive(on: DispatchQueue.main)
      .assign(to: &store.$state)
    return store
  }
}
