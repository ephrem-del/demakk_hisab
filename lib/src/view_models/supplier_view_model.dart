import 'package:demakk_hisab/src/models/model.dart';

class SupplierViewModel {
  final Supplier supplier;
  const SupplierViewModel({required this.supplier});

  String get supplierName {
    return supplier.name;
  }

  String get supplierPhoneNumber {
    return supplier.phoneNumber;
  }

  String get supplierComment {
    return supplier.comment;
  }
}
