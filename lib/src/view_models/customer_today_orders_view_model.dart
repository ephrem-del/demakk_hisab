import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demakk_hisab/src/models/model.dart';

import 'customer_view_model.dart';
import 'order_view_model.dart';

class CustomerTodayOrderViewModel {
  final DateTime forToday = DateTime.now().subtract(
      Duration(hours: DateTime.now().hour, minutes: DateTime.now().minute));
  final todayOrdersStream = StreamController<List<OrderViewModel>>();
  final CustomerViewModel customer;
  CustomerTodayOrderViewModel({required this.customer}) {
    _getTodaysOrders();
  }
  void initState() {
    _getTodaysOrders();
  }

  _getTodaysOrders() async {
    FirebaseFirestore.instance
        .collection('customers')
        .doc(customer.id)
        .collection('orders')
        .orderBy('orderDate', descending: true)
        .where('orderDate', isGreaterThan: forToday)
        .snapshots()
        .listen((data) {
      final orders = data.docs.map((doc) => Order.fromSnapshot(doc)).toList();
      final orderViewModels =
          orders.map((order) => OrderViewModel(order: order)).toList();
      todayOrdersStream.sink.add(orderViewModels);
    });
  }

  cancelOrder(OrderViewModel order) async {
    FirebaseFirestore.instance
        .collection('customers')
        .doc(customer.id)
        .collection('orders')
        .doc(order.id)
        .update({'isCancelled': true});

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final secureSnapshot = await transaction.get(
          FirebaseFirestore.instance.collection('customers').doc(customer.id));
      final double paymentLeft = secureSnapshot.get('paymentLeft') as double;
      transaction.update(secureSnapshot.reference,
          {'paymentLeft': paymentLeft - double.parse(order.paymentLeft)});
    });
  }
}
