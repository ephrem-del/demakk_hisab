import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demakk_hisab/src/models/model.dart';

import 'customer_view_model.dart';

class CustomersListPageViewModel {
  final customersStream = StreamController<List<CustomerViewModel>>();
  CustomersListPageViewModel() {
    _getCustomers();
  }
  void initState() {
    _getCustomers();
  }

  void _getCustomers() async {
    FirebaseFirestore.instance
        .collection('customers')
        .orderBy('name', descending: false)
        .snapshots()
        .listen((data) {
      final customers =
          data.docs.map((doc) => Customer.fromSnapshot(doc)).toList();
      final customerViewModels = customers
          .map((customer) => CustomerViewModel(customer: customer))
          .toList();
      customersStream.sink.add(customerViewModels);
    });
  }

  void dispose() {
    customersStream.close();
  }
}
