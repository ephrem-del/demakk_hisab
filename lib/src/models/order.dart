import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  final String name;
  final String orderType;
  final DateTime orderDate;
  final int amount;
  final int paid;
  final double pricePerSingle;
  final bool isCancelled;
  final String id;
  const Order(
      {required this.name,
      required this.amount,
      required this.pricePerSingle,
      required this.paid,
      required this.orderType,
      required this.orderDate,
      this.isCancelled = false,
        this.id = '',
      });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'orderType': orderType,
      'orderDate': orderDate,
      'amount': amount,
      'paid': paid,
      'pricePerSingle': pricePerSingle,
      'isCancelled': isCancelled
    };
  }

  factory Order.fromSnapshot(QueryDocumentSnapshot doc) {
    return Order(
      name: doc['name'],
      amount: doc['amount'],
      pricePerSingle: doc['pricePerSingle'],
      paid: doc['paid'],
      orderType: doc['orderType'],
      orderDate: doc['orderDate'].toDate(),
      isCancelled: doc['isCancelled'],
      id: doc.id
    );
  }
}
