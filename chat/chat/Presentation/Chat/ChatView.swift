import SwiftUI

struct ChatView: View {
    let userName: String
    @ObservedObject var chatViewModel = F.get(type: IChatViewModel.self) as! ChatViewModel
    @State var message = ""

    var body: some View {
        VStack {
            ScrollView {
                ForEach(chatViewModel.messages, id:\.self) { message in
                    if message.messageType == MessageType.join {
                        joinMessage(message: message)
                    } else {
                        userMessage(message: message)
                    }
                }
            }

            messageTextField()
        }
                .padding(20)
                .navigationBarTitle("Chat", displayMode: .inline)
                .onAppear {
                    chatViewModel.startChatSession(userName: userName)
                }
                .onDisappear {
                    chatViewModel.stopChatSession()
                }
                .alert(
                        isPresented: .constant(!_chatViewModel.wrappedValue.error.isEmpty)) {
                    alert(message: chatViewModel.error)
                }
    }

    private func joinMessage(message: Message) -> some View {
        VStack(spacing: 0) {
            Text(message.message)
                    .font(Font.caption)
                    .foregroundColor(Color.black)
        }
                .frame(height: 16)
                .padding(8)
                .background(RoundedRectangle(cornerRadius: 16))
                .foregroundColor(Color.gray)
    }

    private func userMessage(message: Message) -> some View {
        VStack {
            if message.userName == userName {
                VStack(alignment: .leading) {
                    Text(message.message)
                            .foregroundColor(Color.white)
                }
                        .frame(height: 20)
                        .padding(10)
                        .background(RoundedRectangle(cornerRadius: 8))
                        .foregroundColor(Color.blue)
            } else {
                VStack(alignment: .leading) {
                    Text("\(message.userName ?? "Anonymous"):")
                            .font(Font.caption)
                            .foregroundColor(Color.black)

                    Text(message.message)
                            .foregroundColor(Color.black)
                }
                        .frame(height: 20)
                        .padding(10)
                        .background(RoundedRectangle(cornerRadius: 8))
                        .foregroundColor(Color.gray)
            }
        }
                .frame(
                        maxWidth: .infinity,
                        alignment: message.userName == userName ? .trailing : .leading)
    }

    private func messageTextField() -> some View {
        HStack {
            VStack {
                TextField("Type something...", text: self.$message)
                        .foregroundColor(Color.black)

            }
                    .padding(7)
                    .background(RoundedRectangle(cornerRadius: 8))
                    .foregroundColor(Color.gray)

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

    private func alert(message: String) -> Alert {
        Alert(
                title: Text("Message"),
                message: Text(message),
                primaryButton: .default(Text("Try again"), action: {
                    chatViewModel.cleanError()
                    chatViewModel.startChatSession(userName: userName)
                }),
                secondaryButton: .cancel(Text("Cancel"), action: {
                    chatViewModel.cleanError()
                })
        )
    }
}