import Foundation
import OSLog

protocol APIClientProtocol: Sendable {
    func request<Response: Decodable & Sendable>(
        _ endpoint: any APIEndpoint,
        as responseType: Response.Type
    ) async throws -> Response
}

actor APIClient: APIClientProtocol {
    private let transport: any HTTPTransport
    private let decoder: JSONDecoder

    init(
        transport: any HTTPTransport,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.transport = transport
        self.decoder = decoder
    }

    func request<Response: Decodable & Sendable>(
        _ endpoint: any APIEndpoint,
        as responseType: Response.Type = Response.self
    ) async throws -> Response {
        let request = try URLRequestBuilder.makeRequest(for: endpoint)
        AppLog.networking.info("Request \(endpoint.method.rawValue, privacy: .public) \(request.url?.absoluteString ?? "invalid-url", privacy: .public)")

        let response: HTTPResponse
        do {
            response = try await transport.send(request)
        } catch is CancellationError {
            throw CancellationError()
        } catch let error as NetworkError {
            throw error
        } catch {
            AppLog.networking.error("Transport error: \(String(describing: error), privacy: .private)")
            throw NetworkError.transport
        }

        guard 200..<300 ~= response.statusCode else {
            AppLog.networking.error("HTTP status \(response.statusCode, privacy: .public)")
            throw NetworkError.server(statusCode: response.statusCode)
        }

        do {
            return try decoder.decode(responseType, from: response.data)
        } catch {
            AppLog.networking.error("Decoding error: \(String(describing: error), privacy: .private)")
            throw NetworkError.decoding
        }
    }
}
