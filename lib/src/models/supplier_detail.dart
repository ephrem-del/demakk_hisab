import 'package:cloud_firestore/cloud_firestore.dart';

class SupplierDetail {
  final String item;
  final String price;
  final String id;
  const SupplierDetail({required this.item, required this.price, this.id = ''});

  Map<String, dynamic> toMap() {
    return {'item': item, 'price': price};
  }

  factory SupplierDetail.fromSnapshot(QueryDocumentSnapshot doc) {
    return SupplierDetail(
      item: doc['item'],
      price: doc['price'],
      id: doc.id,
    );
  }
}
