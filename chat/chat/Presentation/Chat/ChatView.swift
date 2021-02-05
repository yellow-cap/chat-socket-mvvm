import SwiftUI

struct ChatView: View {
    let userName: String

    var body: some View {
        Text("Hello, \(userName)")
                .navigationBarTitle("Chat", displayMode: .inline)
    }
}