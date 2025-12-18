package com.tripay

import android.content.Context
import com.tripay.data.AppDatabase
import com.tripay.data.repositories.TransactionRepositoryImpl
import com.tripay.domain.repositories.TransactionRepository

class DependencyProvider(context: Context) {
    private val database = android.arch.persistence.room.Room.databaseBuilder(
        context,
        AppDatabase::class.java, "tripay-db"
    ).build()

    val transactionRepository: TransactionRepository by lazy {
        TransactionRepositoryImpl(database.transactionDao())
    }
}
