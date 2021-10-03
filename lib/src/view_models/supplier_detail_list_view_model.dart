import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demakk_hisab/src/models/supplier_detail.dart';
import 'package:demakk_hisab/src/view_models/supplier_view_model.dart';

import 'supplier_detail_view_model.dart';

class SupplierDetailListViewModel {
  final supplierDetailListStream =
      StreamController<List<SupplierDetailViewModel>>();
  final SupplierViewModel supplier;
  SupplierDetailListViewModel({required this.supplier}) {
    _getSupplierDetailList();
  }

  void initState() {
    _getSupplierDetailList();
  }

  _getSupplierDetailList() async {
    FirebaseFirestore.instance
        .collection('contacts')
        .doc(supplier.id)
        .collection('items')
        .snapshots()
        .listen((data) {
      final supplierDetails =
          data.docs.map((doc) => SupplierDetail.fromSnapshot(doc)).toList();
      final supplierDetailVMs = supplierDetails
          .map((supplierDetail) =>
              SupplierDetailViewModel(supplierDetail: supplierDetail))
          .toList();
      supplierDetailListStream.sink.add(supplierDetailVMs);
    });
  }

  edit(SupplierDetailViewModel supplierDetail, String newPrice) async {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final secureSnapshot = await transaction.get(FirebaseFirestore.instance
          .collection('contacts')
          .doc(supplier.id)
          .collection('items')
          .doc(supplierDetail.id));
      transaction.update(secureSnapshot.reference, {'price': newPrice});
    });
  }

  delete(SupplierDetailViewModel supplierDetail) async {
    await FirebaseFirestore.instance
        .collection('contacts')
        .doc(supplier.id)
        .collection('items')
        .doc(supplierDetail.id)
        .delete();
  }
}
