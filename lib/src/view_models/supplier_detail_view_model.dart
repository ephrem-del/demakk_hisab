import 'package:demakk_hisab/src/models/supplier_detail.dart';

class SupplierDetailViewModel {
  final SupplierDetail supplierDetail;
  const SupplierDetailViewModel({required this.supplierDetail});

  String get item {
    return supplierDetail.item;
  }

  String get price {
    return supplierDetail.price;
  }

  String get id {
    return supplierDetail.id;
  }
}
