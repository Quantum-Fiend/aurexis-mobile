import 'package:hive/hive.dart';

part 'transaction.g.dart';

@HiveType(typeId: 0)
enum TransactionCategory {
  @HiveField(0)
  food,
  @HiveField(1)
  transport,
  @HiveField(2)
  entertainment,
  @HiveField(3)
  shopping,
  @HiveField(4)
  utilities,
  @HiveField(5)
  health,
  @HiveField(6)
  others,
}

@HiveType(typeId: 1)
class Transaction extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final double amount;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  final TransactionCategory category;
  @HiveField(4)
  final String note;

  Transaction({
    required this.id,
    required this.amount,
    required this.date,
    required this.category,
    this.note = '',
  });
}
