import 'package:flutter/material.dart';
import 'package:gastos_app/widgets/chart/chart.dart';
import 'package:gastos_app/widgets/expenses_list/expenses_list.dart';
import 'package:gastos_app/models/expense.dart';
import 'package:gastos_app/widgets/new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: "Comida",
        amount: 100,
        date: DateTime.now(),
        category: Category.food),
    Expense(
        title: "Ropa",
        amount: 200,
        date: DateTime.now(),
        category: Category.leisure),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      builder: (ctx) {
        return NewExpense(_addExpense);
      },
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Gasto eliminado',
          textAlign: TextAlign.center,
        ),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: "Deshacer",
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Widget mainContent = const Text("No hay gastos registrados");
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(_registeredExpenses, _removeExpense);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Control de gastos'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registeredExpenses),
                Expanded(
                  child: mainContent,
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Chart(expenses: _registeredExpenses),
                ),
                Expanded(
                  child: mainContent,
                ),
              ],
            ),
    );
  }
}
