enum ViewState<Content> {
    case idle
    case loading
    case success(Content)
    case empty
    case error(String)
}

extension ViewState: Equatable where Content: Equatable {}

