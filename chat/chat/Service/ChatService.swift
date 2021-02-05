import Foundation

protocol IChatService {
    func startSession()
    func stopSession()
    func joinChat(userName: String)
}

class ChatService: IChatService {
    private var inputStream: InputStream!
    private var outputStream: OutputStream!
    private let maxReadLength = 4096

    func startSession() {
        var readStream: Unmanaged<CFReadStream>?
        var writeStream: Unmanaged<CFWriteStream>?

        CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault,
                "localhost" as CFString,
                80,
                &readStream,
                &writeStream)

        inputStream = readStream!.takeRetainedValue()
        outputStream = writeStream!.takeRetainedValue()

        // inputStream.delegate = self

        inputStream.schedule(in: .current, forMode: .common)
        outputStream.schedule(in: .current, forMode: .common)

        inputStream.open()
        outputStream.open()
    }

    func stopSession() {
        inputStream.close()
        outputStream.close()
    }

    func joinChat(userName: String) {
        let data = "iam:\(userName)".data(using: .utf8)!

        data.withUnsafeBytes {
            guard let pointer = $0.baseAddress?.assumingMemoryBound(to: UInt8.self) else {
                print("Error joining chat")

                return
            }

            outputStream.write(pointer, maxLength: data.count)
        }
    }
}
