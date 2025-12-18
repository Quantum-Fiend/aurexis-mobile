import AppIntents

struct AddTransactionIntent: AppIntent {
    static var title: LocalizedStringResource = "Add TriPay Transaction"
    
    @Parameter(title: "Amount")
    var amount: Double
    
    @Parameter(title: "Note")
    var note: String?
    
    func perform() async throws -> some IntentResult {
        // Logic to save transaction via Domain layer
        return .result()
    }
}
