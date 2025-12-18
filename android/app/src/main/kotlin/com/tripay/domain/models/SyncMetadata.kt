package com.tripay.domain.models

import java.util.Date

enum class SyncStatus {
    LOCAL_ONLY,
    SYNCED,
    CONFLICT,
    PENDING_SYNC
}

data class SyncMetadata(
    val lastSyncedAt: Date?,
    val syncStatus: SyncStatus,
    val version: Int,
    val deviceId: String
)
