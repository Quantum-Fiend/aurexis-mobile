# TriPay Domain Models

## Transaction Model
Mirrored across Swift and Kotlin.

### Swift (iOS)
```swift
import Foundation

enum TransactionCategory: String, Codable, CaseIterable {
    case food = "Food"
    case transport = "Transport"
    case entertainment = "Entertainment"
    case shopping = "Shopping"
    case utilities = "Utilities"
    case health = "Health"
    case others = "Others"
}

struct Transaction: Identifiable, Codable {
    let id: UUID
    let amount: Double
    let date: Date
    let category: TransactionCategory
    let note: String
    
    init(id: UUID = UUID(), amount: Double, date: Date = Date(), category: TransactionCategory, note: String = "") {
        self.id = id
        self.amount = amount
        self.date = date
        self.category = category
        self.note = note
    }
}
```

### Kotlin (Android)
```kotlin
import java.util.UUID
import java.util.Date

enum class TransactionCategory(val displayName: String) {
    FOOD("Food"),
    TRANSPORT("Transport"),
    ENTERTAINMENT("Entertainment"),
    SHOPPING("Shopping"),
    UTILITIES("Utilities"),
    HEALTH("Health"),
    OTHERS("Others")
}

data class Transaction(
    val id: UUID = UUID.randomUUID(),
    val amount: Double,
    val date: Date = Date(),
    val category: TransactionCategory,
    val note: String = ""
)
```
