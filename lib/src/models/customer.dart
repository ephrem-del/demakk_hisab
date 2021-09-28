import 'package:cloud_firestore/cloud_firestore.dart';

import 'order.dart';

class Customer {
  final String name;
  final String phoneNo;
  final double? totalNotPaid;
  final String? id;
  final List<Order> orders;
  const Customer(
      {required this.name,
      required this.phoneNo,
      this.orders = const [],
      this.totalNotPaid = 0,
      this.id = ''});

  Map<String, dynamic> toMap() {
    return {'name': name, 'phoneNo': phoneNo, 'paymentLeft': totalNotPaid};
  }

  factory Customer.fromSnapshot(QueryDocumentSnapshot doc) {
    return Customer(
        name: doc['name'],
        phoneNo: doc['phoneNo'],
        totalNotPaid: doc['paymentLeft'],
        id: doc.id);
  }
}
