import Foundation

struct Message: Hashable {
    let userName: String?
    let messageType: MessageType
    let message: String
}
