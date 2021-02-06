import SwiftUI

struct ChatView: View {
    let userName: String
    @ObservedObject var chatViewModel = F.get(type: IChatViewModel.self) as! ChatViewModel
    @State var message = ""

    var body: some View {
        VStack {
            ScrollView {
                ForEach(chatViewModel.messages, id:\.self) { message in
                    Text(message.message)
                }
            }
            HStack {
                VStack {
                    TextField("Type something...", text: self.$message)
                            .foregroundColor(Color(red: 0, green: 0, blue: 0))

                }
                        .padding(7)
                        .background(RoundedRectangle(cornerRadius: 8))
                        .foregroundColor(Color(red: 239/255, green: 239/255, blue: 240/255))

                Spacer()

                Button("Send") {
                    if message.isEmpty {
                        return
                    }

                    chatViewModel.send(message: message)
                    message = ""
                }
            }
        }
                .padding(20)
                .navigationBarTitle("Chat", displayMode: .inline)
                .onAppear {
                    chatViewModel.startChatSession()
                    chatViewModel.joinChat(userName: userName)
                }
                .onDisappear {
                    chatViewModel.stopChatSession()
                }
    }
}