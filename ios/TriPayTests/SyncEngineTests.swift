import XCTest
@testable import TriPay

final class SyncEngineTests: XCTestCase {
    func testConflictResolution_LocalWinner() {
        let localTx = Transaction(amount: 100.0, date: Date().addingTimeInterval(100), category: .food)
        let remoteTx = Transaction(amount: 50.0, date: Date(), category: .food)
        
        let resolved = SyncEngine.shared.resolveConflict(local: localTx, remote: remoteTx)
        XCTAssertEqual(resolved.amount, 100.0)
    }
    
    func testConflictResolution_RemoteWinner() {
        let localTx = Transaction(amount: 100.0, date: Date(), category: .food)
        let remoteTx = Transaction(amount: 50.0, date: Date().addingTimeInterval(100), category: .food)
        
        let resolved = SyncEngine.shared.resolveConflict(local: localTx, remote: remoteTx)
        XCTAssertEqual(resolved.amount, 50.0)
    }
}
