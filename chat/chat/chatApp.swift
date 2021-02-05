import SwiftUI

@main
struct chatApp: App {
    init() {
        ObjectFactory.initialize(with: DIContainerBuilder.build())
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
