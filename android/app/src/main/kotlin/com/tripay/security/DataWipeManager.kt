package com.tripay.security

import android.content.Context
import com.tripay.data.AppDatabase

class DataWipeManager(private val context: Context, private val database: AppDatabase) {
    suspend fun secureWipe() {
        // 1. Clear Room Database
        database.clearAllTables()
        
        // 2. Clear EncryptedSharedPreferences
        val prefs = SecurityManager.getEncryptedPrefs(context)
        prefs.edit().clear().apply()
        
        // 3. Clear Cache
        context.cacheDir.deleteRecursively()
        
        println("All sensitive data secure-wiped.")
    }
}
