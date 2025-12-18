import Foundation

struct AdvancedAnalytics {
    // Calculate Z-Score for anomaly detection
    static func detectAnomalies(transactions: [Transaction]) -> [Transaction] {
        let amounts = transactions.map { $0.amount }
        let count = Double(amounts.count)
        guard count > 1 else { return [] }
        
        let mean = amounts.reduce(0, +) / count
        let sumOfSquaredDiffs = amounts.map { pow($0 - mean, 2) }.reduce(0, +)
        let standardDeviation = sqrt(sumOfSquaredDiffs / count)
        
        return transactions.filter { tx in
            let zScore = abs(tx.amount - mean) / standardDeviation
            return zScore > 2.0 // Simple threshold for spikes
        }
    }
    
    // Simple Linear Trend for end-of-month prediction
    static func predictMonthlySpend(transactions: [Transaction], totalDaysInMonth: Int) -> Double {
        let currentSpend = transactions.reduce(0) { $0 + $1.amount }
        let dates = transactions.map { $0.date }
        guard let firstDate = dates.min(), let lastDate = dates.max() else { return currentSpend }
        
        let daysElapsed = Calendar.current.dateComponents([.day], from: firstDate, to: lastDate).day ?? 1
        let dailyRate = currentSpend / Double(max(1, daysElapsed))
        
        return dailyRate * Double(totalDaysInMonth)
    }
}
