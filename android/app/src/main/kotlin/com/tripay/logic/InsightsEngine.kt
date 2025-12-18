package com.tripay.logic

import com.tripay.models.Transaction
import com.tripay.models.TransactionCategory

object InsightsEngine {
    fun calculateTotalSpending(transactions: List<Transaction>): Double {
        return transactions.sumOf { it.amount }
    }
    
    fun categorizeSpending(transactions: List<Transaction>): Map<TransactionCategory, Double> {
        return transactions.groupBy { it.category }
            .mapValues { entry -> entry.value.sumOf { it.amount } }
    }
}
