import Testing
@testable import ARKDex

struct HomeSearchStateTests {
    @Test
    func hidesSuggestionsForAnEmptyQuery() {
        let state = HomeSearchState()

        #expect(!state.showsSuggestions)
    }

    @Test
    func hidesSuggestionsForAWhitespaceQuery() {
        let state = HomeSearchState(query: " \n ")

        #expect(!state.showsSuggestions)
    }

    @Test
    func showsSuggestionsAfterTyping() {
        let state = HomeSearchState(query: "Rex")

        #expect(state.showsSuggestions)
    }
}
