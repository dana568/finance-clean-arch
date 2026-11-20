import '../entities/transaction_item.dart';

abstract class ITransactionRepository {
  Future<void> add(TransactionItem item);
  Future<List<TransactionItem>> getAll();
}