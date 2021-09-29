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
        child: Column(
          children: [
            Row(
              children: [
                Text('Name'),
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    controller: _nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name is required';
                      }
                    },
                    keyboardType: TextInputType.name,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text('Phone no:'),
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    controller: _phoneNumberController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Phone Number required';
                      }
                    },
                    keyboardType: TextInputType.phone,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text('Comment'),
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    controller: _commentController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Comment is required';
                      }
                    },
                    keyboardType: TextInputType.phone,
                  ),
                ),
              ],
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
    );
  }
}
