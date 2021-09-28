import 'package:demakk_hisab/src/view_models/add_expense_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({Key? key}) : super(key: key);

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController amountController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final AddExpenseViewModel _addExpenseVM = AddExpenseViewModel();

  void _addExpense(BuildContext context) async {
    // bool isAdded = false;
    final _title = titleController.text;
    final _description = descriptionController.text;
    final _amount = amountController.text;
    if (_formKey.currentState!.validate()) {
      await _addExpenseVM.addExpense(_title, _description, _amount);
      //if (isAdded) {
      Navigator.pop(context);
      //}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                validator: (value) {
                  if (value == null) {
                    return 'ርዕስ አስገባ';
                  } else if (value.isEmpty) {
                    return 'ርዕስ አስገባ';
                  }
                },
                decoration: const InputDecoration(
                  hintText: 'የወጪ ርዕስ',
                  label: Text('ርዕስ'),
                ),
              ),
              TextFormField(
                controller: descriptionController,
                minLines: 1,
                maxLines: 5,
                //expands: true,
                validator: (value) {
                  if (value == null) {
                    return 'የወጪ ዝርዝር አስገባ';
                  } else if (value.isEmpty) {
                    return 'የወጪ ዝርዝር አስገባ';
                  }
                },
                decoration: const InputDecoration(
                  hintText: 'የወጪ ዝርዝር',
                  label: Text('ዝርዝር'),
                ),
              ),
              TextFormField(
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: amountController,
                validator: (value) {
                  if (value == null) {
                    return 'የብር መጠን አስገባ';
                  } else if (value.isEmpty) {
                    return 'የብር መጠን አስገባ';
                  }
                },
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: 'የብር መጠን',
                  label: Text('የብር መጠን'),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _addExpense(context);
                },
                child: Text('ወጪ መዝግብ'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
