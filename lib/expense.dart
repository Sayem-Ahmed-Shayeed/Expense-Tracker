import 'package:expense_track/chart.dart';
import 'package:expense_track/expens_list.dart';
import 'package:expense_track/expense_blueprint.dart';
import 'package:expense_track/modal_sheet.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return ExpenseState();
  }
}

class ExpenseState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Ostaad Course',
      amount: 12.00,
      date: DateTime.now(),
      category: Category.study,
    ),
    Expense(
      title: 'Dinner With Her',
      amount: 500.00,
      date: DateTime.now(),
      category: Category.gf,
    ),
    Expense(
      title: 'Dinner me',
      amount: 10.00,
      date: DateTime.now(),
      category: Category.food,
    ),
  ];

  void _openModalSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => ModalSheetWidget(
        onAddExpense: addNewExpense,
      ),
    );
  }

  void addNewExpense(Expense newExpense) {
    setState(() {
      _registeredExpenses.add(newExpense);
    });
  }

  void removeExpense(Expense expense) {
    var index = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
            textColor: Colors.green,
            label: 'Undo',
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(index, expense);
              });
            }),
        content: const Row(
          children: [
            Row(
              children: [
                Icon(
                  Icons.error_sharp,
                  color: Colors.red,
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  "Expense Deleted!",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text(
        "No Expense! Try Adding Some",
      ),
    );
    if (_registeredExpenses.isNotEmpty) {
      mainContent = Column(
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(
            child: ExpenseList(
              expenses: _registeredExpenses,
              onRemoveExpense: removeExpense,
            ),
          ),
        ],
      );
    }
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _openModalSheet,
            icon: const Icon(Icons.add),
          ),
        ],
        title: const Text(
          'Track   Your   Expense',
          textAlign: TextAlign.start,
        ),
      ),
      body: mainContent,
    );
  }
}
