import 'package:demakk_hisab/src/view_models/add_contact_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddContactPage extends StatefulWidget {
  AddContactPage({Key? key}) : super(key: key);

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _phoneNumberController = TextEditingController();

  final TextEditingController _commentController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final AddContactViewModel _addContactViewModel = AddContactViewModel();

  void _addContact(BuildContext context) async {
    final String name = _nameController.text;
    final String phoneNumber = _phoneNumberController.text;
    final String comment = _commentController.text;
    if (_formKey.currentState!.validate()) {
      await _addContactViewModel.addContact(name, phoneNumber, comment);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Supplier Contact'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is required';
                    }
                  },
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Phone no',
                  ),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  controller: _phoneNumberController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone Number required';
                    }
                  },
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  controller: _commentController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Comment is required';
                    }
                  },
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    labelText: 'Comment',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    _addContact(context);
                  },
                  child: Text('Add Contact'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
