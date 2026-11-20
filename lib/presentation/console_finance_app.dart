import 'dart:io';

import '../application/use_cases/add_transaction_use_case.dart';
import '../application/use_cases/get_balance_summary_use_case.dart';
import '../application/use_cases/get_transactions_use_case.dart';

class ConsoleFinanceApp {
  final AddTransactionUseCase addTransactionUseCase;
  final GetTransactionsUseCase getTransactionsUseCase;
  final GetBalanceSummaryUseCase getBalanceSummaryUseCase;

  ConsoleFinanceApp({
    required this.addTransactionUseCase,
    required this.getTransactionsUseCase,
    required this.getBalanceSummaryUseCase,
  });

  Future<void> run() async {
    while (true) {
      print('\n=== ФІНАНСОВИЙ МЕНЕДЖЕР (Clean Architecture) ===');
      print('1. Додати дохід');
      print('2. Додати витрату');
      print('3. Переглянути історію транзакцій');
      print('4. Переглянути підсумковий баланс');
      print('0. Вихід');
      stdout.write('Оберіть дію: ');

      final choice = stdin.readLineSync(encoding: systemEncoding)?.trim();

      switch (choice) {
        case '1':
          await _handleAddTransaction(isExpense: false);
          break;
        case '2':
          await _handleAddTransaction(isExpense: true);
          break;
        case '3':
          await _handleShowTransactions();
          break;
        case '4':
          await _handleShowBalance();
          break;
        case '0':
          print('Роботу завершено.');
          return;
        default:
          print('Невідома команда. Введіть цифру від 0 до 4.');
      }
    }
  }

  Future<void> _handleAddTransaction({required bool isExpense}) async {
    stdout.write('Введіть назву операції: ');
    final title = stdin.readLineSync(encoding: systemEncoding)?.trim() ?? '';

    stdout.write('Введіть суму (грн): ');
    final amountInput =
        stdin.readLineSync(encoding: systemEncoding)?.trim().replaceAll(',', '.') ?? '';
    final amount = double.tryParse(amountInput);

    if (amount == null || amount <= 0) {
      print('Помилка: сума має бути додатним числом.');
      return;
    }

    try {
      await addTransactionUseCase.execute(
        title: title,
        amount: amount,
        isExpense: isExpense,
      );
      print(isExpense ? 'Витрату успішно додано.' : 'Дохід успішно додано.');
    } catch (e) {
      print('Помилка: $e');
    }
  }

  Future<void> _handleShowTransactions() async {
    final transactions = await getTransactionsUseCase.execute();
    if (transactions.isEmpty) {
      print('\nСписок транзакцій порожній.');
      return;
    }

    print('\n--- Історія транзакцій ---');
    for (final item in transactions) {
      final sign = item.isExpense ? '-' : '+';
      final dateStr = item.date.toIso8601String().substring(0, 10);
      print('[$dateStr] ${item.title}: $sign${item.amount.toStringAsFixed(2)} грн');
    }
  }

  Future<void> _handleShowBalance() async {
    final summary = await getBalanceSummaryUseCase.execute();
    print('\n--- Фінансовий підсумок ---');
    print('Загальні доходи:  +${summary.totalIncome.toStringAsFixed(2)} грн');
    print('Загальні витрати: -${summary.totalExpense.toStringAsFixed(2)} грн');
    print('Поточний баланс:   ${summary.balance.toStringAsFixed(2)} грн');
  }
}