import Foundation
import Combine

protocol TransactionRepository {
    func getTransactions() -> AnyPublisher<[Transaction], Error>
    func saveTransaction(_ transaction: Transaction) -> AnyPublisher<Void, Error>
    func deleteTransaction(_ transaction: Transaction) -> AnyPublisher<Void, Error>
}
