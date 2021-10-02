import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demakk_hisab/src/models/model.dart';

class AddContactViewModel {
  Future<bool> addContact(
      String name, String phoneNumber, String comment, String location) async {
    bool _isSaved = false;
    final String _name = name;
    final String _phoneNumber = phoneNumber;
    final String _comment = comment;
    final String _location = location;

    final _supplier = Supplier(
      name: _name,
      phoneNumber: _phoneNumber,
      comment: _comment,
      location: _location,
    );

    try {
      await FirebaseFirestore.instance
          .collection('contacts')
          .add(_supplier.toMap());
      _isSaved = true;
    } on FirebaseException {
      return _isSaved;
    }
    return _isSaved;
  }
}
