import 'package:car/models/transaction.dart';

class TransactionPage {
  final List<Transaction> transactions;
  final int totalCount;

  TransactionPage({
    required this.transactions,
    required this.totalCount,
  });

  factory TransactionPage.fromJson(Map<String, dynamic> json) {
    // Trích xuất danh sách từ object 'list'
    final List<dynamic> transactionListJson = json['list'] as List;
    
    // Ánh xạ mỗi item trong danh sách JSON thành một đối tượng Transaction
    final List<Transaction> transactionList = transactionListJson
        .map((item) => Transaction.fromJson(item as Map<String, dynamic>))
        .toList();

    return TransactionPage(
      transactions: transactionList,
      totalCount: json['count'] as int,
    );
  }
}