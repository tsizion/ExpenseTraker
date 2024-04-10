import 'package:expense_tacker/widgets/expensesList/expenses_list.dart';
import 'package:flutter/material.dart';
import 'package:expense_tacker/model/expense.dart';
import 'package:expense_tacker/widgets/new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _resisteredExpenses = [
    Expense(
        amount: 19.23,
        date: DateTime.now(),
        title: "Flutter Course",
        category: Category.work),
    Expense(
        amount: 19.23,
        date: DateTime.now(),
        title: "Cinema",
        category: Category.leisure),
  ];
  void _openAddExpense() {
    showModalBottomSheet(
        context: context, builder: (ctx) => const NewExpense());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Expense tracker"),
        actions: [
          IconButton(
            onPressed: _openAddExpense,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Text("the Chart"),
          Expanded(
            child: ExpensesList(expenses: _resisteredExpenses),
          )
        ],
      ),
    );
  }
}
