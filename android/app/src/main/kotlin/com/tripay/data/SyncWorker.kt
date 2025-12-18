package com.tripay.data

import android.content.Context
import androidx.work.CoroutineWorker
import androidx.work.WorkerParameters

class SyncWorker(appContext: Context, workerParams: WorkerParameters) :
    CoroutineWorker(appContext, workerParams) {

    override suspend fun doWork(): Result {
        return try {
            val syncEngine = SyncEngine()
            syncEngine.performSync()
            Result.success()
        } catch (e: Exception) {
            Result.retry()
        }
    }
}
