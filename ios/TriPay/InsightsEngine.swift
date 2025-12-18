import Foundation

struct InsightsEngine {
    static func calculateTotalSpending(transactions: [Transaction]) -> Double {
        return transactions.reduce(0) { $0 + $1.amount }
    }
    
    static func categorizeSpending(transactions: [Transaction]) -> [TransactionCategory: Double] {
        var result: [TransactionCategory: Double] = [:]
        for transaction in transactions {
            result[transaction.category, default: 0] += transaction.amount
        }
        return result
    }
}
