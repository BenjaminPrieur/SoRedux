import SwiftUI

struct ContentView: View {
  @EnvironmentObject var store: AppStore
  @State private var showingSheet = false

  var body: some View {
    NavigationView {
      VStack {
        AuthView()
          .environmentObject(store.derived(
            deriveState: \.userState,
            embedAction: AppAction.user,
            deriveEnvironment: \.userEnvironment
          ))
          .padding(.bottom, 16)
        Spacer()

        NavigationLink(isActive: $showingSheet,
                       destination: {
          UserDetailsView()
            .environmentObject(store.derived(
              deriveState: \.userState,
              embedAction: AppAction.user,
              deriveEnvironment: \.userEnvironment
            ))
            .environmentObject(store.derived(
              deriveState: \.fixtureState,
              embedAction: AppAction.fixture,
              deriveEnvironment: \.fixtureEnvironment
            ))
        }, label: {
          Text("UserDetails")
        })
      }
      .padding()
      .onChange(of: store.state.userState.currentUser, perform: { newValue in
        showingSheet = newValue != nil
      })
      .debugAction {
        print("ContentView updated")
      }
    }
  }
}



struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .environmentObject(AppStore(
        initialState: .init(userState: .init(), fixtureState: .init()),
        reducer: appReducer,
        environment: .init())
      )
  }
}

