import '../../domain/entities/transaction_item.dart';
import '../../domain/interfaces/i_transaction_repository.dart';

class GetTransactionsUseCase {
  final ITransactionRepository repository;

  GetTransactionsUseCase(this.repository);

  Future<List<TransactionItem>> execute() async {
    final items = await repository.getAll();
   items.sort((a, b) => b.date.compareTo(a.date));
    return items;
  }
}