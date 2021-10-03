import 'package:demakk_hisab/src/models/wifi_customer.dart';

class WifiCustomerViewModel {
  final WifiCustomer wifiCustomer;
  const WifiCustomerViewModel({required this.wifiCustomer});

  String get name {
    return wifiCustomer.name;
  }

  String get macAddress {
    return wifiCustomer.macAddress;
  }
}

WifiCustomer customer = WifiCustomer(name: 'ephrem', macAddress: '1w2sa4f56g');
