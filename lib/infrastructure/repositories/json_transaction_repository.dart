import 'dart:convert';
import 'dart:io';

import '../../domain/entities/transaction_item.dart';
import '../../domain/interfaces/i_transaction_repository.dart';

class JsonTransactionRepository implements ITransactionRepository {
  final String filePath;

  JsonTransactionRepository({this.filePath = 'transactions.json'});

  @override
  Future<List<TransactionItem>> getAll() async {
    final file = File(filePath);
    if (!await file.exists()) {
      return [];
    }

    final content = await file.readAsString();
    if (content.trim().isEmpty) {
      return [];
    }

    final List<dynamic> jsonList = jsonDecode(content) as List<dynamic>;
    return jsonList.map((item) {
      final map = item as Map<String, dynamic>;
      return TransactionItem(
        id: map['id'] as String,
        title: map['title'] as String,
        amount: (map['amount'] as num).toDouble(),
        isExpense: map['isExpense'] as bool,
        date: DateTime.parse(map['date'] as String),
      );
    }).toList();
  }

  @override
  Future<void> add(TransactionItem transaction) async {
    final items = await getAll();
    items.add(transaction);
    await _saveAll(items);
  }

  Future<void> delete(String id) async {
    final items = await getAll();
    items.removeWhere((item) => item.id == id);
    await _saveAll(items);
  }

  Future<void> _saveAll(List<TransactionItem> items) async {
    final file = File(filePath);
    final jsonList = items
        .map((item) => {
              'id': item.id,
              'title': item.title,
              'amount': item.amount,
              'isExpense': item.isExpense,
              'date': item.date.toIso8601String(),
            })
        .toList();

    const encoder = JsonEncoder.withIndent('  ');
    await file.writeAsString(encoder.convert(jsonList));
  }
}