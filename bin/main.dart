import '../lib/application/use_cases/add_transaction_use_case.dart';
import '../lib/application/use_cases/get_balance_summary_use_case.dart';
import '../lib/application/use_cases/get_transactions_use_case.dart';
import '../lib/infrastructure/repositories/json_transaction_repository.dart';
import '../lib/presentation/console_finance_app.dart';

Future<void> main() async {
  final repository = JsonTransactionRepository(filePath: 'transactions.json');

  final addTransactionUseCase = AddTransactionUseCase(repository);
  final getTransactionsUseCase = GetTransactionsUseCase(repository);
  final getBalanceSummaryUseCase = GetBalanceSummaryUseCase(repository);

  final app = ConsoleFinanceApp(
    addTransactionUseCase: addTransactionUseCase,
    getTransactionsUseCase: getTransactionsUseCase,
    getBalanceSummaryUseCase: getBalanceSummaryUseCase,
  );

  await app.run();
}