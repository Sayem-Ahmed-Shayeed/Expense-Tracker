import 'package:expense_track/card_widget.dart';
import 'package:expense_track/expense_blueprint.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  ExpenseList(
      {super.key, required this.expenses, required this.onRemoveExpense});

  List<Expense> expenses;
  void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctx, index) => Dismissible(
          background: const Icon(Icons.delete),
          onDismissed: (direction) {
            onRemoveExpense(expenses[index]);
          },
          key: ValueKey(expenses[index]),
          child: ExpenseItem(
            expenses: expenses[index],
          ),
        ),
      ),
    );
  }
}
