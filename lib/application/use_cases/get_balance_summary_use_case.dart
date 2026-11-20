import '../../domain/interfaces/i_transaction_repository.dart';

class BalanceSummary {
  final double totalIncome;
  final double totalExpense;
  final double balance;

  BalanceSummary({
    required this.totalIncome,
    required this.totalExpense,
  }) : balance = totalIncome - totalExpense;
}

class GetBalanceSummaryUseCase {
  final ITransactionRepository repository;

  GetBalanceSummaryUseCase(this.repository);

  Future<BalanceSummary> execute() async {
    final transactions = await repository.getAll();
    double income = 0;
    double expense = 0;

    for (final item in transactions) {
      if (item.isExpense) {
        expense += item.amount;
      } else {
        income += item.amount;
      }
    }

    return BalanceSummary(
      totalIncome: income,
      totalExpense: expense,
    );
  }
}