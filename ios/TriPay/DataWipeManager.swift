import Foundation
import CoreData

class DataWipeManager {
    static let shared = DataWipeManager()
    
    func secureWipe() {
        // 1. Clear Core Data
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "TransactionEntity")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try PersistenceController.shared.container.viewContext.execute(deleteRequest)
            try PersistenceController.shared.container.viewContext.save()
            print("Database wiped successfully.")
        } catch {
            print("Error wiping database: \(error)")
        }
        
        // 2. Clear Keychain
        let query = [kSecClass: kSecClassGenericPassword] as CFDictionary
        SecItemDelete(query)
        
        // 3. Clear Logs
        // TriPayLogger.shared.clear()
    }
}
