# Financial Insights Engine Implementation

This logic is mirrored across platforms.

## Swift Logic
```swift
struct InsightsEngine {
    static fun calculateTotalSpending(transactions: [Transaction]) -> Double {
        return transactions.reduce(0) { $0 + $1.amount }
    }
    
    static fun categorizeSpending(transactions: [Transaction]) -> [TransactionCategory: Double] {
        var result: [TransactionCategory: Double] = [:]
        for transaction in transactions {
            result[transaction.category, default: 0] += transaction.amount
        }
        return result
    }
}
```

## Kotlin Logic
```kotlin
object InsightsEngine {
    fun calculateTotalSpending(transactions: List<Transaction>): Double {
        return transactions.sumOf { it.amount }
    }
    
    fun categorizeSpending(transactions: List<Transaction>): Map<TransactionCategory, Double> {
        return transactions.groupBy { it.category }
            .mapValues { entry -> entry.value.sumOf { it.amount } }
    }
}
```
