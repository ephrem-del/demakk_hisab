import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demakk_hisab/src/models/model.dart';

import 'customer_view_model.dart';
import 'order_view_model.dart';

class CustomersWeeklyOrdersViewModel {
  final CustomerViewModel customer;
  final weeklyStream = StreamController<List<OrderViewModel>>();

  CustomersWeeklyOrdersViewModel({required this.customer}) {
    getWeeklyOrders();
  }

  void initState() {
    getWeeklyOrders();
  }

  DateTime getWeeklyDate() {
    if (DateTime.now().weekday == 7) {
      return DateTime.now().subtract(
        Duration(
            days: 6,
            hours: DateTime.now().hour,
            minutes: DateTime.now().minute,
            seconds: DateTime.now().second),
      );
    } else if (DateTime.now().weekday == 6) {
      return DateTime.now().subtract(Duration(
          days: 5,
          hours: DateTime.now().hour,
          minutes: DateTime.now().minute,
          seconds: DateTime.now().second));
    } else if (DateTime.now().weekday == 5) {
      return DateTime.now().subtract(Duration(
          days: 4,
          hours: DateTime.now().hour,
          minutes: DateTime.now().minute,
          seconds: DateTime.now().second));
    } else if (DateTime.now().weekday == 4) {
      return DateTime.now().subtract(Duration(
          days: 3,
          hours: DateTime.now().hour,
          minutes: DateTime.now().minute,
          seconds: DateTime.now().second));
    } else if (DateTime.now().weekday == 3) {
      return DateTime.now().subtract(Duration(
          days: 2,
          hours: DateTime.now().hour,
          minutes: DateTime.now().minute,
          seconds: DateTime.now().second));
    } else if (DateTime.now().weekday == 2) {
      return DateTime.now().subtract(Duration(
          days: 1,
          hours: DateTime.now().hour,
          minutes: DateTime.now().minute,
          seconds: DateTime.now().second));
    } else {
      return DateTime.now().subtract(Duration(
          hours: DateTime.now().hour,
          minutes: DateTime.now().minute,
          seconds: DateTime.now().second));
    }
  }

  getWeeklyOrders() {
    FirebaseFirestore.instance
        .collection('customers')
        .doc(customer.id)
        .collection('orders')
        .where('orderDate', isGreaterThan: getWeeklyDate())
        .orderBy('orderDate', descending: true)
        .snapshots()
        .listen((data) {
      final _orders = data.docs.map((doc) => Order.fromSnapshot(doc)).toList();
      final _ordersViewModel =
          _orders.map((order) => OrderViewModel(order: order)).toList();
      weeklyStream.sink.add(_ordersViewModel);
    });
  }

  cancelOrder(OrderViewModel order) async {
    FirebaseFirestore.instance
        .collection('customers')
        .doc(customer.id)
        .collection('orders')
        .doc(order.id)
        .update({'isCancelled': true});
  }
}
