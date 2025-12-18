import Foundation

enum LogLevel: String {
    case info = "INFO"
    case warning = "WARN"
    case error = "ERROR"
    case debug = "DEBUG"
}

struct LogEntry: Identifiable, Codable {
    let id = UUID()
    let timestamp = Date()
    let level: LogLevel
    let message: String
    let category: String
}

class TriPayLogger {
    static let shared = TriPayLogger()
    private var logs: [LogEntry] = []
    
    func log(_ message: String, level: LogLevel = .info, category: String = "General") {
        let entry = LogEntry(level: level, message: message, category: category)
        logs.append(entry)
        print("[\(level.rawValue)] [\(category)] \(message)")
        // In production, write to a file or remote observability tool
    }
    
    func getLogs() -> [LogEntry] {
        return logs
    }
}
