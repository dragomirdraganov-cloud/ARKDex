import Foundation

struct HomeServiceLive: HomeService {
    private let apiClient: any APIClientProtocol
    private let baseURL: URL
    private let timeout: TimeInterval

    init(
        apiClient: any APIClientProtocol,
        baseURL: URL,
        timeout: TimeInterval
    ) {
        self.apiClient = apiClient
        self.baseURL = baseURL
        self.timeout = timeout
    }

    func fetchHome() async throws -> HomeContent {
        let dto = try await apiClient.request(
            HomeEndpoint(baseURL: baseURL, timeout: timeout),
            as: HomeDTO.self
        )
        return try HomeMapper.map(dto)
    }
}

private struct HomeEndpoint: APIEndpoint {
    let baseURL: URL
    let timeout: TimeInterval
    let path = "/posts/1"
    let method = HTTPMethod.get
}

private struct HomeDTO: Decodable, Sendable {
    let id: Int
    let title: String
    let body: String
}

private enum HomeMapper {
    static func map(_ dto: HomeDTO) throws -> HomeContent {
        guard dto.id > 0, !dto.title.isEmpty else {
            throw HomeServiceError.unavailable
        }

        return HomeContent(
            id: String(dto.id),
            title: dto.title,
            message: dto.body
        )
    }
}

