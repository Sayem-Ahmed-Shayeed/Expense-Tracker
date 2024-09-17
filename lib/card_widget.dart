import 'package:expense_track/expense_blueprint.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key, required this.expenses});

  final Expense expenses;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(expenses.title,
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  '\$${(expenses.amount).toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                ),
                const Spacer(),
                Icon(
                  categoryIcons[expenses.category],
                  size: 18,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  expenses.getFormattedDate,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 14,
                      ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
