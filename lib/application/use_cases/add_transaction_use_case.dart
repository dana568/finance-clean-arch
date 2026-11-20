import '../../domain/entities/transaction_item.dart';
import '../../domain/interfaces/i_transaction_repository.dart';

class AddTransactionUseCase {
  final ITransactionRepository repository;

  AddTransactionUseCase(this.repository);

  Future<void> execute({
    required String title,
    required double amount,
    required bool isExpense,
    DateTime? date,
  }) async {
    if (title.trim().isEmpty) {
      throw ArgumentError('Назва транзакції не може бути порожньою.');
    }

    final transaction = TransactionItem(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: title.trim(),
      amount: amount,
      isExpense: isExpense,
      date: date ?? DateTime.now(),
    );

    await repository.add(transaction);
  }
}