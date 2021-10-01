import 'package:cloud_firestore/cloud_firestore.dart';

class SupplierDetail {
  final String item;
  final String price;
  const SupplierDetail({required this.item, required this.price});

  Map<String, dynamic> toMap() {
    return {'item': item, 'price': price};
  }

  factory SupplierDetail.fromSnapshot(QueryDocumentSnapshot doc) {
    return SupplierDetail(
      item: doc['item'],
      price: doc['price'],
    );
  }
}
