import XCTest
@testable import TriPay

final class InsightsTests: XCTestCase {
    func testTotalSpending() {
        let transactions = [
            Transaction(amount: 100.0, category: .food),
            Transaction(amount: 50.0, category: .transport)
        ]
        XCTAssertEqual(InsightsEngine.calculateTotalSpending(transactions: transactions), 150.0)
    }
}
