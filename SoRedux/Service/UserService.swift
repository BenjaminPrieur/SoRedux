import Foundation
import Combine

class UserService {
  private let session: URLSession
  private let decoder: JSONDecoder

  init(session: URLSession = .shared, decoder: JSONDecoder = .init()) {
    self.session = session
    self.decoder = decoder
  }

  func auth(email: String, password: String) -> AnyPublisher<User, Error> {
    return Just(User(id: "", nickname: "benMainSo5"))
      .setFailureType(to: Error.self)
      .eraseToAnyPublisher()
  }
}
