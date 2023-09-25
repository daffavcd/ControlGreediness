import 'package:intl/intl.dart';

class TransactionModel {
  final String date;
  final String amount;
  final String description;
  final String type;

  TransactionModel({
    required this.date,
    required this.amount,
    required this.description,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "date": date,
      "amount": amount,
      "description": description,
      "type": type,
    };
  }

  @override
  String toString() {
    return 'TransactionModel{date: $date, amount: $amount, description: $description, type: $type}';
  }
}
