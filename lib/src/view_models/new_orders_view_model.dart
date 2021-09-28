import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demakk_hisab/src/models/model.dart';

import 'order_view_model.dart';

class NewOrdersViewModel {
  final newOrdersStream = StreamController<List<OrderViewModel>>();
  final totalTodayStream = StreamController<int>();
  final DateTime forToday = DateTime.now().subtract(
      Duration(hours: DateTime.now().hour, minutes: DateTime.now().minute));
  NewOrdersViewModel() {
    getOrders();
  }

  void initState() {
    getOrders();
  }

  getOrders() {
    FirebaseFirestore.instance
        .collectionGroup('orders')
        .where('orderDate', isGreaterThan: forToday)
        .orderBy('orderDate', descending: true)
        .snapshots()
        .listen((data) {
      final _orders = data.docs.map((doc) => Order.fromSnapshot(doc)).toList();
      final _orderViewModels =
          _orders.map((order) => OrderViewModel(order: order)).toList();
      newOrdersStream.sink.add(_orderViewModels);
      int totalToday = 0;
      _orders.where((order) => !order.isCancelled).forEach((order) {
        totalToday = totalToday + order.paid;
      });
      totalTodayStream.sink.add(totalToday);
    });
  }
}
