package com.tripay.logic

import com.tripay.models.Transaction
import kotlin.math.pow
import kotlin.math.sqrt

object AdvancedAnalytics {
    fun detectAnomalies(transactions: List<Transaction>): List<Transaction> {
        val amounts = transactions.map { it.amount }
        val count = amounts.size
        if (count <= 1) return emptyList()

        val mean = amounts.average()
        val stdDev = sqrt(amounts.map { (it - mean).pow(2.0) }.sum() / count)

        return transactions.filter { tx ->
            val zScore = Math.abs(tx.amount - mean) / stdDev
            zScore > 2.0
        }
    }
}
