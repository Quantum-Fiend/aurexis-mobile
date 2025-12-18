import SwiftUI

struct ConflictResolutionView: View {
    let localItem: Transaction
    let remoteItem: Transaction
    var onResolve: (Transaction) -> Void
    
    var body: some View {
        VStack(spacing: 25) {
            Text("Resolve Sync Conflict")
                .font(.title2).bold()
            
            Text("Multiple changes detected for a transaction. Which one should we keep?")
                .multilineTextAlignment(.center)
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.horizontal)
            
            HStack(spacing: 20) {
                // Local Option
                VStack {
                    Text("Current Device")
                        .font(.caption).bold()
                    TransactionPreview(tx: localItem)
                    Button("Keep Local") { onResolve(localItem) }
                        .buttonStyle(.borderedProminent)
                }
                
                Divider()
                
                // Remote Option
                VStack {
                    Text("Cloud Version")
                        .font(.caption).bold()
                    TransactionPreview(tx: remoteItem)
                    Button("Keep Cloud") { onResolve(remoteItem) }
                        .buttonStyle(.bordered)
                }
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(20)
        }
        .padding()
    }
}

struct TransactionPreview: View {
    let tx: Transaction
    var body: some View {
        VStack {
            Text("$\(tx.amount, specifier: "%.2f")")
                .font(.headline)
            Text(tx.category.rawValue)
                .font(.caption)
        }
        .padding()
    }
}
