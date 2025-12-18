package com.tripay.models

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
