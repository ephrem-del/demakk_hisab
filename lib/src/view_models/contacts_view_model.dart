import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demakk_hisab/src/models/customer.dart';
import 'package:demakk_hisab/src/models/model.dart';
import 'package:demakk_hisab/src/view_models/customer_view_model.dart';
import 'package:demakk_hisab/src/view_models/supplier_view_model.dart';

class ContactsViewModel {
  final customersStream = StreamController<List<CustomerViewModel>>();
  final suppliersStream = StreamController<List<SupplierViewModel>>();

  ContactsViewModel() {
    _getCustomers();
    _getSuppliers();
  }

  void initState() {
    _getCustomers();
    _getSuppliers();
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

  void _getSuppliers() async {
    FirebaseFirestore.instance
        .collection('contacts')
        .orderBy('name', descending: false)
        .snapshots()
        .listen((data) {
      final suppliers =
          data.docs.map((doc) => Supplier.fromSnapshot(doc)).toList();
      final suppliersViewModel = suppliers
          .map((supplier) => SupplierViewModel(supplier: supplier))
          .toList();

      suppliersStream.sink.add(suppliersViewModel);
    });
  }

  void dispose() {
    customersStream.close();
  }
}
