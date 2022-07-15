import SwiftUI

struct UserDetailsView: View {
  @EnvironmentObject var userStore: UserStore
  @EnvironmentObject var fixtureStore: FixtureStore

  var body: some View {
    if let currentUser = userStore.state.currentUser {
      VStack {
        Text("User")
        Text("id: \(currentUser.id)")
        Text("nickname: \(currentUser.nickname)")

        Button(action: loadFixture) {
          Text("Load featured fixtures")
        }
      }
      .debugAction {
        print("UserDetailsView updated")
      }
    }
  }

  private func loadFixture() {
    fixtureStore.send(.loadFeatured)
  }
}
