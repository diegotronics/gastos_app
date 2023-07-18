import 'package:flutter/material.dart';
import 'package:gastos_app/models/expense.dart';
import 'package:gastos_app/widgets/expenses_list/expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(this.expenses, this.onRemoveExpense, {super.key});

  final List<Expense> expenses;
  final void Function(Expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(expenses[index]),
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 16),
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal,
          ),
          child: const Icon(
            Icons.delete,
            color: Colors.white,
            size: 40,
          ),
        ),
        onDismissed: ((direction) => onRemoveExpense(expenses[index])),
        child: ExpenseItem(expenses[index]),
      ),
    );
  }
}
