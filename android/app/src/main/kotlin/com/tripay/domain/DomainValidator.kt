package com.tripay.domain

import com.tripay.models.Transaction
import java.util.Date

sealed class ValidationError : Exception() {
    object InvalidAmount : ValidationError()
    object NoteTooLong : ValidationError()
    object FutureDate : ValidationError()
}

object DomainValidator {
    fun validate(transaction: Transaction) {
        if (transaction.amount <= 0) {
            throw ValidationError.InvalidAmount
        }

        if (transaction.note.length > 250) {
            throw ValidationError.NoteTooLong
        }

        if (transaction.date.after(Date())) {
            throw ValidationError.FutureDate
        }
    }
}
