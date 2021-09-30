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

  bool withVat = true;

  final _formKey = GlobalKey<FormState>();

  final AddExpenseViewModel _addExpenseVM = AddExpenseViewModel();

  void _addExpense(BuildContext context) async {
    // bool isAdded = false;
    final _title = titleController.text;
    final _description = descriptionController.text;
    final _amount = amountController.text;
    final _withVat = withVat;
    if (_formKey.currentState!.validate()) {
      await _addExpenseVM.addExpense(_title, _description, _amount, _withVat);
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
                    return 'Title required';
                  } else if (value.isEmpty) {
                    return 'Title required';
                  }
                },
                decoration: const InputDecoration(
                  hintText: 'Expense Title',
                  label: Text('Title'),
                ),
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                controller: descriptionController,
                minLines: 1,
                maxLines: 5,
                //expands: true,
                validator: (value) {
                  if (value == null) {
                    return 'Description required';
                  } else if (value.isEmpty) {
                    return 'Description required';
                  }
                },
                decoration: const InputDecoration(
                  hintText: 'Expense description',
                  label: Text('Description'),
                ),
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: amountController,
                validator: (value) {
                  if (value == null) {
                    return 'Amount required';
                  } else if (value.isEmpty) {
                    return 'Amount required';
                  }
                },
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: 'Amount',
                  label: Text('Amount'),
                ),
                textInputAction: TextInputAction.done,
              ),
              CheckboxListTile(
                  title: Text('With VAT?'),
                  value: withVat,
                  onChanged: (value) {
                    setState(() {
                      withVat = value ?? false;
                    });
                  }),
              ElevatedButton(
                onPressed: () {
                  _addExpense(context);
                },
                child: Text('Add Expense'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
