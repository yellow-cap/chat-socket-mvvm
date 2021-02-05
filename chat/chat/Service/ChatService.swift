import Foundation

protocol IChatService {
    func startSession()
    func stopSession()
    func joinChat(userName: String)
}

class ChatService: IChatService {
    private var inputStream: InputStream? = nil
    private var outputStream: OutputStream? = nil
    private let maxReadLength = 4096

    func startSession() {
        var readStream: Unmanaged<CFReadStream>?
        var writeStream: Unmanaged<CFWriteStream>?

        // TODO ARTEM: check if server is available
        CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault,
                "localhost" as CFString,
                80,
                &readStream,
                &writeStream)

        inputStream = readStream!.takeRetainedValue()
        outputStream = writeStream!.takeRetainedValue()

        // inputStream.delegate = self

        guard let inputStream = inputStream,
              let outputStream = outputStream else {

            print("<<<DEV>>> input or output stream is nil")

            return
        }

        inputStream.schedule(in: .current, forMode: .common)
        outputStream.schedule(in: .current, forMode: .common)

        inputStream.open()
        outputStream.open()
    }

    func stopSession() {
        guard let inputStream = inputStream,
              let outputStream = outputStream else {

            print("<<<DEV>>> input or output stream is nil")

            return
        }

        inputStream.close()
        outputStream.close()
    }

    func joinChat(userName: String) {
        let data = "iam:\(userName)".data(using: .utf8)!

        guard let outputStream = outputStream else {
            print("<<<DEV>>> output stream is nil")

            return
        }

        data.withUnsafeBytes {
            guard let pointer = $0.baseAddress?.assumingMemoryBound(to: UInt8.self) else {
                print("Error joining chat")

                return
            }

            outputStream.write(pointer, maxLength: data.count)
        }
    }
}
