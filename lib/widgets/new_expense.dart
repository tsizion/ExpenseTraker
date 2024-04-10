import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() => __NewExpenseState();
}

class __NewExpenseState extends State<NewExpense> {
  final _textController = TextEditingController();
  final _amountController = TextEditingController();
  @override
  void dispose() {
    _textController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _presentDatePicker() {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = DateTime(now.year + 5, now.month, now.day);

    showDatePicker(context: context, firstDate: firstDate, lastDate: lastDate);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              maxLength: 50,
              decoration: const InputDecoration(label: Text("Title")),
            ),
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
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Selected Date"),
                    IconButton(
                        onPressed: _presentDatePicker,
                        icon: const Icon(Icons.calendar_month))
                  ],
                ),
              )
            ],
          ),
          Row(
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("cancel")),
              ElevatedButton(
                  onPressed: () {
                    print(_textController.text);
                    print(_amountController.text);
                  },
                  child: const Text("save expense ")),
            ],
          )
        ],
      ),
    );
  }
}
