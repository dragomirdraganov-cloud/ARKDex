import Testing
import UIKit
@testable import SwiftUIMVVMTemplate

struct AppTypographyTests {
    @Test
    func registersMontserratVariableFontWeights() {
        #expect(UIFont(name: "Montserrat-Regular", size: 17) != nil)
        #expect(UIFont(name: "Montserrat-SemiBold", size: 17) != nil)
        #expect(UIFont(name: "Montserrat-Bold", size: 28) != nil)
        #expect(UIFont(name: "Montserrat-Italic", size: 17) != nil)
    }
}
