import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demakk_hisab/src/models/customer.dart';
import 'package:demakk_hisab/src/view_models/customer_view_model.dart';

class ContactsViewModel {
  final customersStream = StreamController<List<CustomerViewModel>>();

  ContactsViewModel() {
    _getCustomers();
  }

  void initState() {
    _getCustomers();
  }

  _getCustomers() async {
    FirebaseFirestore.instance
        .collection('customers')
        .orderBy('name', descending: false)
        .snapshots()
        .listen((data) {
      final customers =
          data.docs.map((doc) => Customer.fromSnapshot(doc)).toList();
      final customersViewModel = customers
          .map((customer) => CustomerViewModel(customer: customer))
          .toList();
      customersStream.sink.add(customersViewModel);
    });
  }

  void dispose() {
    customersStream.close();
  }
}
