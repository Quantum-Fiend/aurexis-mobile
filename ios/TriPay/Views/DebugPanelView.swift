import SwiftUI

struct DebugPanelView: View {
    @State private var logs = TriPayLogger.shared.getLogs()
    
    var body: some View {
        List {
            Section(header: Text("App State")) {
                Text("Sync Engine: Idle")
                Text("Database: Encypted (AES-256)")
            }
            
            Section(header: Text("Recent Logs")) {
                ForEach(logs) { log in
                    VStack(alignment: .leading) {
                        HStack {
                            Text(log.level.rawValue)
                                .font(.caption2)
                                .padding(4)
                                .background(colorFor(log.level))
                                .cornerRadius(4)
                            Text(log.category)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        Text(log.message)
                            .font(.system(size: 14, design: .monospaced))
                    }
                }
            }
        }
        .navigationTitle("Internal Debug")
    }
    
    private func colorFor(_ level: LogLevel) -> Color {
        switch level {
        case .error: return .red
        case .warning: return .yellow
        case .info: return .blue
        case .debug: return .gray
        }
    }
}
