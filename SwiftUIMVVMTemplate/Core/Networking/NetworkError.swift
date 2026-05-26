enum NetworkError: Error, Equatable {
    case invalidURL
    case invalidResponse
    case decodingFailed
    case serverError(statusCode: Int)
    case unknown
}

