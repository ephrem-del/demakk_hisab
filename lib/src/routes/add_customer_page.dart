import 'package:demakk_hisab/src/view_models/add_customer_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddCustomerPage extends StatefulWidget {
  const AddCustomerPage({Key? key}) : super(key: key);

  @override
  State<AddCustomerPage> createState() => _AddCustomerPageState();
}

class _AddCustomerPageState extends State<AddCustomerPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  final _phoneNoController = TextEditingController();

  final AddCustomerViewModel _addCustomerViewModel = AddCustomerViewModel();

  void _addCustomer(BuildContext context) async {
    //bool isSaved = false;
    final String name = _nameController.text;
    final String phoneNo = _phoneNoController.text;
    if (_formKey.currentState!.validate()) {
      await _addCustomerViewModel.addCustomer(name, phoneNo);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('አዲስ ደንበኛ'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null) {
                    return 'የደንበኛ ስም አስገባ';
                  }
                  if (value.isEmpty) {
                    return 'የደንበኛ ስም አስገባ';
                  }
                },
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: 'የደንበኛ ስም',
                  label: Text('የደንበኛ ስም'),
                ),
              ),
              TextFormField(
                validator: (value) {
                  if (value == null) {
                    return 'የደንበኛ ስልክ ቁጥር አስገባ';
                  }
                  if (value.isEmpty) {
                    return 'የደንበኛ ስልክ ቁጥር አስገባ';
                  }
                },
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: _phoneNoController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: 'የደንበኛ ስልክ ቁጥር',
                  label: Text('ስልክ ቁጥር'),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _addCustomer(context);
                },
                child: const Text('አዲስ ደንበኛ ጨምር'),
              )
            ],
          ),
        ),
      ),
    );
  }
}