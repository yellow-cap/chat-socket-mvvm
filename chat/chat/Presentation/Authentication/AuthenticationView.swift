import SwiftUI

struct AuthenticationView: View {
    @State var name = ""
    @State var isChatActive: Bool = false

    var body: some View {
        VStack {
            VStack {
                TextField("Enter your name", text: self.$name)
                        .foregroundColor(Color(red: 0, green: 0, blue: 0))

            }
                    .padding(7)
                    .background(RoundedRectangle(cornerRadius: 8))
                    .foregroundColor(Color(red: 239/255, green: 239/255, blue: 240/255))

            Button("Start chat") {
                if name.isEmpty {
                    return
                }

                isChatActive = true
            }

            NavigationLink(destination: ChatView(), isActive: $isChatActive) {
                EmptyView()
            }
        }
                .navigationBarTitle("Authentication")
                .padding(20)

    }
}

