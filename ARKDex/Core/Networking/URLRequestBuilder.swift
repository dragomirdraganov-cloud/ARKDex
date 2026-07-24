import Foundation

enum URLRequestBuilder {
    static func makeRequest(for endpoint: any APIEndpoint) throws -> URLRequest {
        var components = URLComponents(
            url: endpoint.baseURL.appending(path: endpoint.path),
            resolvingAgainstBaseURL: false
        )
        components?.queryItems = endpoint.queryItems.isEmpty ? nil : endpoint.queryItems

        guard let url = components?.url else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(
            url: url,
            cachePolicy: endpoint.cachePolicy,
            timeoutInterval: endpoint.timeout
        )
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headers
        request.httpBody = endpoint.body
        return request
    }
}

