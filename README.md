# Фінансовий менеджер (`finance-clean-arch`)

Консольний застосунок для обліку особистих доходів і витрат, розроблений мовою **Dart** за принципами **Clean Architecture** із використанням методології розгалуження **Git Flow** та стандарту **Conventional Commits**.

---

## Архітектура проєкту (Clean Architecture)

Проєкт розділений на чотири ізольовані шари з дотриманням правила залежностей (**Dependency Rule** — внутрішні шари не залежать від зовнішніх):

1. **Domain (`lib/domain/`)** — ядро бізнес-логіки, незалежне від зовнішніх бібліотек і способів збереження даних:
   * `entities/transaction_item.dart` — сутність фінансової транзакції (`TransactionItem`).
   * `interfaces/i_transaction_repository.dart` — абстрактний інтерфейс репозиторію (`ITransactionRepository`).
2. **Application (`lib/application/`)** — сценарії використання (Use Cases), що реалізують бізнес-правила:
   * `use_cases/add_transaction_use_case.dart` — валідація та додавання доходу або витрати (`AddTransactionUseCase`).
   * `use_cases/get_transactions_use_case.dart` — отримання історії транзакцій (`GetTransactionsUseCase`).
   * `use_cases/get_balance_summary_use_case.dart` — підрахунок загальних доходів, витрат і поточного балансу (`GetBalanceSummaryUseCase`, `BalanceSummary`).
3. **Infrastructure (`lib/infrastructure/`)** — реалізація зовнішніх залежностей і сховища даних:
   * `repositories/json_transaction_repository.dart` — імплементація `ITransactionRepository` для асинхронного збереження транзакцій у локальний JSON-файл (`transactions.json`).
4. **Presentation (`lib/presentation/`)** — інтерфейс взаємодії з користувачем:
   * `console_finance_app.dart` — текстове консольне меню (`ConsoleFinanceApp`).
5. **Composition Root (`bin/main.dart`)** — точка входу в застосунок, де виконується впровадження залежностей (**Dependency Injection**) між усіма шарами.

---

## Структура репозиторію

```text
finance-clean-arch/
├── bin/
│   └── main.dart
├── lib/
│   ├── application/
│   │   └── use_cases/
│   │       ├── add_transaction_use_case.dart
│   │       ├── get_balance_summary_use_case.dart
│   │       └── get_transactions_use_case.dart
│   ├── domain/
│   │   ├── entities/
│   │   │   └── transaction_item.dart
│   │   └── interfaces/
│   │       └── i_transaction_repository.dart
│   ├── infrastructure/
│   │   └── repositories/
│   │       └── json_transaction_repository.dart
│   └── presentation/
│       └── console_finance_app.dart
├── pubspec.yaml
└── README.md