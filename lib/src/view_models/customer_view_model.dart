import 'package:demakk_hisab/src/models/model.dart';

class CustomerViewModel {
  final Customer customer;
  const CustomerViewModel({required this.customer});

  String get customerName {
    return customer.name;
  }

  String get paymentLeft {
    return customer.totalNotPaid.toString();
  }

  String get phoneNo {
    return customer.phoneNo;
  }

  String? get id {
    return customer.id;
  }
}
