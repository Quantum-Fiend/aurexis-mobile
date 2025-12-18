import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/transaction.dart';
import 'screens/dashboard_screen.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionAdapter());
  Hive.registerAdapter(TransactionCategoryAdapter());
  
  await Hive.openBox<Transaction>('transactions');
  
  runApp(const TriPayCompanion());
}

class TriPayCompanion extends StatelessWidget {
  const TriPayCompanion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TriPay Companion',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.black,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const DashboardScreen(transactions: []), // Initially empty
    );
  }
}
