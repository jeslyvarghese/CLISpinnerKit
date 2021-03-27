import XCTest
@testable import CLISpinnerKit

final class CLIAnimationKitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let spinner = Spinner(frames: ["-", "\\", "|", "/"], delay: 1/60)
        spinner.start()
        spinner.log("Hello World")
        sleep(10)
        spinner.log("Updating With More Info")
        sleep(10)
        spinner.log("Stopping")
        spinner.stop()
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
