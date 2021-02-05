import SwiftUI

struct AuthenticationView: View {
    @State var userName = ""
    @State var isChatActive: Bool = false

    var body: some View {
        VStack {
            VStack {
                TextField("Enter your name", text: self.$userName)
                        .foregroundColor(Color(red: 0, green: 0, blue: 0))

            }
                    .padding(7)
                    .background(RoundedRectangle(cornerRadius: 8))
                    .foregroundColor(Color(red: 239/255, green: 239/255, blue: 240/255))

            Button("Start chat") {
                if userName.isEmpty {
                    return
                }

                isChatActive = true
            }

            NavigationLink(
                    destination: ChatContainer(
                            props: ChatContainerProps(userName: userName)
                    ),
                    isActive: $isChatActive
            ) {
                EmptyView()
            }
        }
                .navigationBarTitle("Authentication")
                .padding(20)

    }
}

