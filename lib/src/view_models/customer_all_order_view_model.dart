import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demakk_hisab/src/models/model.dart';

import 'customer_view_model.dart';
import 'order_view_model.dart';

class CustomerAllOrderViewModel {
  final allOrdersStream = StreamController<List<OrderViewModel>>();
  final CustomerViewModel customer;
  CustomerAllOrderViewModel({required this.customer}) {
    getAllOrders();
  }
  void initState() {
    getAllOrders();
  }

  getAllOrders() async {
    FirebaseFirestore.instance
        .collection('customers')
        .doc(customer.id)
        .collection('orders')
        .orderBy('orderDate', descending: true)
        .snapshots()
        .listen((data) {
      final orders = data.docs.map((doc) => Order.fromSnapshot(doc)).toList();
      final orderViewModels =
          orders.map((order) => OrderViewModel(order: order)).toList();
      allOrdersStream.sink.add(orderViewModels);
    });
  }
}
