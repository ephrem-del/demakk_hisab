import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demakk_hisab/src/models/supplier_detail.dart';

import 'supplier_view_model.dart';

class AddSupplierDetailViewModel {
  Future<bool> addSupplierDetail(
      String item, String price, SupplierViewModel supplier) async {
    bool _isAdded = false;
    final String _item = item;
    final String _price = price;
    final String _id = supplier.id;
    final SupplierDetail detail = SupplierDetail(item: _item, price: _price);
    try {
      FirebaseFirestore.instance
          .collection('contacts')
          .doc(_id)
          .collection('items')
          .add(detail.toMap());
      _isAdded = true;
    } on FirebaseException {
      return _isAdded;
    } catch (e) {
      return _isAdded;
    }
    return _isAdded;
  }
}
