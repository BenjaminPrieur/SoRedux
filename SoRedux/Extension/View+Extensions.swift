import SwiftUI

public extension View {
  @discardableResult
  func print(_ value: Any) -> Self {
    Swift.print(value)
    return self
  }

  func debugPrint(_ value: Any) -> Self {
    debugAction { _ = print(value) }
  }

  func debugAction(_ closure: () -> Void) -> Self {
#if DEBUG
    closure()
#endif
    return self
  }
}
