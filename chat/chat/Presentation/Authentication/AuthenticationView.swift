import SwiftUI

struct AuthenticationView: View {
    @State var userName = ""
    @State var isChatActive: Bool = false

    var body: some View {
        VStack {
            VStack {
                TextField("Enter your name", text: self.$userName)
                        .foregroundColor(Color.black)

            }
                    .padding(7)
                    .background(RoundedRectangle(cornerRadius: 8))
                    .foregroundColor(Color.gray)

            Button("Start chat") {
                if userName.isEmpty {
                    return
                }

                isChatActive = true
            }

            NavigationLink(
                    destination: ChatView(userName: userName),
                    isActive: $isChatActive
            ) {
                EmptyView()
            }
        }
                .padding(20)
                .navigationBarTitle("Authentication")

    }
}

