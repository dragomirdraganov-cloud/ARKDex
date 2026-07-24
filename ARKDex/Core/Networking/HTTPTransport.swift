import Foundation

struct HTTPResponse: Sendable, Equatable {
    let data: Data
    let statusCode: Int
}

protocol HTTPTransport: Sendable {
    func send(_ request: URLRequest) async throws -> HTTPResponse
}

struct URLSessionHTTPTransport: HTTPTransport {
    private let session: URLSession

    init(session: URLSession) {
        self.session = session
    }

    func send(_ request: URLRequest) async throws -> HTTPResponse {
        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        return HTTPResponse(data: data, statusCode: httpResponse.statusCode)
    }
}

