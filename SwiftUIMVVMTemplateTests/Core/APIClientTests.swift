import Foundation
import Testing
@testable import SwiftUIMVVMTemplate

struct APIClientTests {
    @Test
    func decodesSuccessfulResponse() async throws {
        let data = Data(#"{"value":"ok"}"#.utf8)
        let transport = HTTPTransportStub(
            result: .success(HTTPResponse(data: data, statusCode: 200))
        )
        let client = APIClient(transport: transport)

        let response = try await client.request(
            TestEndpoint(),
            as: TestResponse.self
        )

        #expect(response == TestResponse(value: "ok"))
    }

    @Test
    func mapsServerStatusToTypedError() async {
        let transport = HTTPTransportStub(
            result: .success(HTTPResponse(data: Data(), statusCode: 503))
        )
        let client = APIClient(transport: transport)

        do {
            let _: TestResponse = try await client.request(
                TestEndpoint(),
                as: TestResponse.self
            )
            Issue.record("Expected a server error")
        } catch let error as NetworkError {
            #expect(error == .server(statusCode: 503))
        } catch {
            Issue.record("Unexpected error: \(error)")
        }
    }

    @Test
    func buildsBodyHeadersAndTimeout() throws {
        let endpoint = TestEndpoint(
            method: .post,
            headers: ["Content-Type": "application/json"],
            body: Data("{}".utf8),
            timeout: 4
        )

        let request = try URLRequestBuilder.makeRequest(for: endpoint)

        #expect(request.httpMethod == "POST")
        #expect(request.value(forHTTPHeaderField: "Content-Type") == "application/json")
        #expect(request.httpBody == Data("{}".utf8))
        #expect(request.timeoutInterval == 4)
    }
}

private struct TestResponse: Codable, Equatable, Sendable {
    let value: String
}

private struct TestEndpoint: APIEndpoint {
    let baseURL = URL(string: "https://example.com") ?? URL(fileURLWithPath: "/")
    let path = "/resource"
    var method: HTTPMethod = .get
    var headers: [String: String] = [:]
    var body: Data?
    var timeout: TimeInterval = 15
}

private struct HTTPTransportStub: HTTPTransport {
    let result: Result<HTTPResponse, StubTransportError>

    func send(_ request: URLRequest) async throws -> HTTPResponse {
        try result.get()
    }
}

private enum StubTransportError: Error, Sendable {
    case failed
}

