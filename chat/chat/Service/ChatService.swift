import Foundation

protocol IChatService {
    func startSession(userName: String)
    func stopSession()
    func send(message: String)
}

class ChatService: NSObject, IChatService, StreamDelegate {
    let onMessageReceived: (Message) -> Void
    let onError: (String) -> Void

    init(onMessageReceived: @escaping (Message) -> Void, onError: @escaping (String) -> Void) {
        self.onMessageReceived = onMessageReceived
        self.onError = onError
    }

    private var inputStream: InputStream? = nil
    private var outputStream: OutputStream? = nil
    private let maxReadLength = 4096

    func startSession(userName: String) {
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

        guard let inputStream = inputStream,
              let outputStream = outputStream else {
            print("<<<DEV>>> input or output stream is nil")

            return
        }

        inputStream.delegate = self
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

    private func joinChat(userName: String) {
        let data = "iam:\(userName)".data(using: .utf8)!

        guard let outputStream = outputStream else {
            print("<<<DEV>>> output stream is nil")

            return
        }

        data.withUnsafeBytes {
            guard let pointer = $0.baseAddress?.assumingMemoryBound(to: UInt8.self) else {
                print("<<<DEV>>> Error joining chat")

                return
            }

            outputStream.write(pointer, maxLength: data.count)
        }
    }

    func send(message: String) {
        let data = "msg:\(message)".data(using: .utf8)!

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

    func stream(_ aStream: Stream, handle eventCode: Stream.Event) {
        switch eventCode {
        case .hasBytesAvailable:
            print("<<<DEV>>> New message received")
            readAvailableBytes(stream: aStream as! InputStream)
        case .endEncountered:
            print("<<<DEV>>> New message received")
        case .errorOccurred:
            print("<<<DEV>> Error occurred")
        case .hasSpaceAvailable:
            print("<<<DEV>> Has space available")
        case .openCompleted:
            print("<<<DEV>>> Connection open complete")
        default:
            print("<<<DEV>> Event is not defined")
        }
    }

    private func readAvailableBytes(stream: InputStream) {
        guard let inputStream = inputStream else {
            print("<<<DEV>>> input stream is nil")

            return
        }

        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: maxReadLength)

        while stream.hasBytesAvailable {
            let numberOfBytesRead = inputStream.read(buffer, maxLength: maxReadLength)

            if numberOfBytesRead < 0, let error = stream.streamError {
                print("<<<DEV>> Error while reading from the stream:  \(error)")

                break
            }

            guard let message = MessageHelper.buildMessage(buffer: buffer, length: numberOfBytesRead) else {
                onError("<<<DEV>>> Couldn't build message from input stream")
                return
            }

            onMessageReceived(message)
        }
    }
}
