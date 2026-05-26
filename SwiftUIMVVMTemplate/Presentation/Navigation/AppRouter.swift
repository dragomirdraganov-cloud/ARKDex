import Observation
import SwiftUI

@MainActor
@Observable
final class AppRouter {
    var path: [AppRoute] = []

    func navigate(to route: AppRoute) {
        path.append(route)
    }

    func goBack() {
        _ = path.popLast()
    }

    func reset() {
        path.removeAll()
    }
}

extension AppRouter {
    var pathBinding: Binding<[AppRoute]> {
        Binding(
            get: { self.path },
            set: { self.path = $0 }
        )
    }
}

