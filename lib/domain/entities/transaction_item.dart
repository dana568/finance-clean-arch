class TransactionItem {
  final String id;
  final String title;
  final double amount;
  final bool isExpense;
  final DateTime date;

  TransactionItem({
    required this.id,
    required this.title,
    required this.amount,
    required this.isExpense,
    required this.date,
  }) {
    if (amount <= 0) {
      throw ArgumentError('Сума транзакції повинна бути більшою за нуль.');
    }
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'amount': amount,
        'isExpense': isExpense,
        'date': date.toIso8601String(),
      };

  factory TransactionItem.fromJson(Map<String, dynamic> json) {
    return TransactionItem(
      id: json['id'] as String,
      title: json['title'] as String,
      amount: (json['amount'] as num).toDouble(),
      isExpense: json['isExpense'] as bool,
      date: DateTime.parse(json['date'] as String),
    );
  }

String get formattedAmount {
    final sign = isExpense ? '-' : '+';
    return '$sign${amount.toStringAsFixed(2)} UAH';
  }
}