import Foundation

enum ValidationError: Error {
    case invalidAmount
    case noteTooLong
    case futureDate
}

struct DomainValidator {
    static func validate(transaction: Transaction) throws {
        if transaction.amount <= 0 {
            throw ValidationError.invalidAmount
        }
        
        if transaction.note.count > 250 {
            throw ValidationError.noteTooLong
        }
        
        if transaction.date > Date() {
            throw ValidationError.futureDate
        }
    }
}
