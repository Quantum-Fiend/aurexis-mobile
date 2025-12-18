import Foundation

enum SyncStatus: String, Codable {
    case localOnly = "LocalOnly"
    case synced = "Synced"
    case conflict = "Conflict"
    case pendingSync = "PendingSync"
}

struct SyncMetadata: Codable {
    var lastSyncedAt: Date?
    var syncStatus: SyncStatus
    var version: Int
    var deviceId: String
}
