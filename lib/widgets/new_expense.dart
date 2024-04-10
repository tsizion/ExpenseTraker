import 'package:flutter/material.dart';
import 'package:expense_tacker/model/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});
  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => __NewExpenseState();
}

class __NewExpenseState extends State<NewExpense> {
  final _textController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;
  @override
  void dispose() {
    _textController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = DateTime(now.year + 5, now.month, now.day);

    final pickedDate = await showDatePicker(
        context: context, firstDate: firstDate, lastDate: lastDate);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    try {
      final enteredAmount = double.parse(_amountController.text);
      final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
      if (_textController.text.trim().isEmpty ||
          amountIsInvalid ||
          _selectedDate == null) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Invalid Input"),
            content: const Text(
                "Please make sure you have entered a valid title, amount, date, and category."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx); // Dismiss the dialog
                },
                child: Text("Okay"),
              )
            ],
          ),
        );
        return;
      }

      widget.onAddExpense(Expense(
          amount: enteredAmount,
          date: _selectedDate!,
          title: _textController.text,
          category: _selectedCategory));
    } catch (e) {
      // Handle exception if parsing double fails
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Invalid Input"),
          content: const Text("Please enter a valid amount."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx); // Dismiss the dialog
              },
              child: Text("Okay"),
            )
          ],
        ),
      );
      print('Error parsing amount: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _textController,
            maxLength: 50,
            decoration: const InputDecoration(label: Text("Title")),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: '\$',
                    label: Text("amount"),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(_selectedDate == null
                      ? 'Selected Date'
                      : formatter.format(_selectedDate!)),
                  IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.calendar_month))
                ],
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              DropdownButton(
                  value: _selectedCategory,
                  items: Category.values
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.name),
                        ),
                      )
                      .toList(),
                  onChanged: (val) {
                    if (val == null) {
                      return;
                    }
                    setState(() {
                      _selectedCategory = val;
                    });
                    print(val);
                  }),
              const Spacer(),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("cancel")),
              ElevatedButton(
                  onPressed: _submitExpenseData,
                  child: const Text("save expense ")),
            ],
          )
        ],
      ),
    );
  }
}
