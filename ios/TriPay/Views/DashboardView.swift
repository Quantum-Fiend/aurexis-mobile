import SwiftUI

struct DashboardView: View {
    @State private var totalBalance: Double = 12540.50
    @State private var transactions: [Transaction] = [
        Transaction(amount: 50.0, category: .food, note: "Lunch"),
        Transaction(amount: 15.0, category: .transport, note: "Uber")
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Balance Card
                    VStack(alignment: .leading) {
                        Text("Total Balance")
                            .font(.headline)
                            .foregroundColor(.white.opacity(0.8))
                        Text("$\(totalBalance, specifier: "%.2f")")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .cornerRadius(20)
                    .shadow(radius: 10)
                    
                    // Recent Transactions
                    Text("Recent Transactions")
                        .font(.title2)
                        .bold()
                    
                    ForEach(transactions) { tx in
                        HStack {
                            Circle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(width: 50, height: 50)
                                .overlay(Text("🍴")) // Dynamic icon based on category
                            
                            VStack(alignment: .leading) {
                                Text(tx.category.rawValue)
                                    .font(.headline)
                                Text(tx.note)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            
                            Text("-\(tx.amount, specifier: "$%.2f")")
                                .font(.headline)
                                .foregroundColor(.red)
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 5)
                    }
                }
                .padding()
            }
            .navigationTitle("TriPay")
            .background(Color(.systemGroupedBackground))
        }
    }
}
