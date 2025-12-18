import Foundation

class DIContainer {
    static let shared = DIContainer()
    
    private init() {}
    
    lazy var transactionRepository: TransactionRepository = {
        return TransactionRepositoryImpl(dataSource: CoreDataTransactionDataSource.shared)
    }()
    
    // Add other dependencies here...
}
