package com.tripay.data

import com.tripay.models.Transaction
import java.util.Date

class SyncEngine {
    fun resolveConflict(local: Transaction, remote: Transaction): Transaction {
        return if (local.date.after(remote.date)) local else remote
    }

    suspend fun performSync() {
        // Background sync logic using WorkManager
        println("Syncing data in background...")
    }
}
