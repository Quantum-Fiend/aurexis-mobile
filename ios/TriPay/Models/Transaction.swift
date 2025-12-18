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
