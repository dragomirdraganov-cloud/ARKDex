enum NetworkError: Error, Equatable, Sendable {
    case invalidURL
    case invalidResponse
    case transport
    case server(statusCode: Int)
    case decoding

    var code: String {
        switch self {
        case .invalidURL:
            "network.invalid_url"
        case .invalidResponse:
            "network.invalid_response"
        case .transport:
            "network.transport"
        case .server:
            "network.server"
        case .decoding:
            "network.decoding"
        }
    }
}

