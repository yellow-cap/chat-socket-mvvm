import Foundation

class MessageHelper {
    static func buildMessage(
            buffer: UnsafeMutablePointer<UInt8>,
            length: Int) -> Message? {

        guard let stringArray = String(
                bytesNoCopy: buffer,
                length: length,
                encoding: .utf8,
                freeWhenDone: true)?.components(separatedBy: ":"), !stringArray.isEmpty else {
            return nil
        }

        if stringArray.count == 1 {
            return Message(
                    userName: nil,
                    messageType: .join,
                    message: stringArray[0].trimmingCharacters(in: .whitespacesAndNewlines)
            )
        } else {
            return Message(
                    userName: stringArray[0],
                    messageType: .message,
                    message: stringArray[1].trimmingCharacters(in: .whitespacesAndNewlines)
            )
        }
    }
}
