import SwiftUI

@main
struct SoReduxApp: App {
  let store = AppStore(
    initialState: .init(userState: .init(), fixtureState: .init()),
    reducer: appReducer,
    environment: .init()
  )

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(store)
    }
  }
}
