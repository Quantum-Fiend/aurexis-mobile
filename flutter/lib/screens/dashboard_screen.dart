import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart' as model;

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final Box<model.Transaction> _transactionsBox = Hive.box<model.Transaction>('transactions');

  void _addMockTransaction() {
    final newTx = model.Transaction(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      amount: (10 + (DateTime.now().millisecond % 90)).toDouble(),
      date: DateTime.now(),
      category: model.TransactionCategory.values[DateTime.now().millisecond % model.TransactionCategory.values.length],
      note: 'Mock Transaction',
    );
    _transactionsBox.put(newTx.id, newTx);
  }

  void _clearAll() {
    _transactionsBox.clear();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('TriPay Companion'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: _clearAll,
            tooltip: 'Clear All',
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addMockTransaction,
            tooltip: 'Add Mock Tx',
          ),
        ],
      ),
      body: ValueListenableBuilder<Box<model.Transaction>>(
        valueListenable: _transactionsBox.listenable(),
        builder: (context, box, _) {
          final transactions = box.values.toList()
            ..sort((a, b) => b.date.compareTo(a.date)); // descending

          final double totalAmount = transactions.fold(0, (sum, tx) => sum + tx.amount);

          return LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 600;
              
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: isWide ? constraints.maxWidth * 0.1 : 20.0,
                  vertical: 20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBalanceCard(totalAmount, isDark),
                    const SizedBox(height: 30),
                    const Text('Recent Activity', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 15),
                    
                    if (transactions.isEmpty)
                      _buildEmptyState(isDark)
                    else if (isWide)
                      _buildGrid(transactions, isDark)
                    else
                      _buildList(transactions, isDark),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addMockTransaction,
        icon: const Icon(Icons.receipt_long),
        label: const Text('New Expense'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: isDark ? Colors.black : Colors.white,
      ),
    );
  }

  Widget _buildBalanceCard(double total, bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark 
            ? [const Color(0xFF1E1E1E), const Color(0xFF2C2C2C)]
            : [Colors.black, const Color(0xFF2C3E50)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: (isDark ? Colors.white : Colors.black).withAlpha(25), // 0.1 * 255 = ~25
            blurRadius: 15,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Total Expenses', style: TextStyle(color: Colors.white70, fontSize: 16)),
          const SizedBox(height: 10),
          Text(
            NumberFormat.currency(symbol: '\$', decimalDigits: 2).format(total),
            style: const TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(bool isDark) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60.0),
        child: Column(
          children: [
            Icon(Icons.inbox_outlined, size: 80, color: isDark ? Colors.grey[700] : Colors.grey[300]),
            const SizedBox(height: 20),
            Text(
              'No recent activity',
              style: TextStyle(fontSize: 18, color: isDark ? Colors.grey[400] : Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList(List<model.Transaction> txs, bool isDark) {
    return Column(
      children: txs.map((tx) => _buildTransactionCard(tx, isDark)).toList(),
    );
  }

  Widget _buildGrid(List<model.Transaction> txs, bool isDark) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 3,
      ),
      itemCount: txs.length,
      itemBuilder: (context, index) {
        return _buildTransactionCard(txs[index], isDark, margin: EdgeInsets.zero);
      },
    );
  }

  Widget _buildTransactionCard(model.Transaction tx, bool isDark, {EdgeInsetsGeometry? margin}) {
    return Container(
      margin: margin ?? const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(isDark ? 76 : 13), // 0.3 * 255 = 76, 0.05 * 255 = 13
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[800] : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(_getIconForCategory(tx.category), color: isDark ? Colors.white : Colors.black),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  tx.category.name.toUpperCase(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  DateFormat('MMM dd, yyyy - hh:mm a').format(tx.date),
                  style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ),
          Text(
            '-\$${tx.amount.toStringAsFixed(2)}',
            style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }

  IconData _getIconForCategory(model.TransactionCategory category) {
    switch (category) {
      case model.TransactionCategory.food: return Icons.fastfood_outlined;
      case model.TransactionCategory.transport: return Icons.directions_car_outlined;
      case model.TransactionCategory.entertainment: return Icons.movie_outlined;
      case model.TransactionCategory.shopping: return Icons.shopping_bag_outlined;
      case model.TransactionCategory.utilities: return Icons.bolt_outlined;
      case model.TransactionCategory.health: return Icons.favorite_outline;
      case model.TransactionCategory.others: return Icons.more_horiz;
    }
  }
}
