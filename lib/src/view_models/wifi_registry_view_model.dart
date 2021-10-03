import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demakk_hisab/src/models/wifi_customer.dart';
import 'package:demakk_hisab/src/view_models/wifi_customer_view_model.dart';

class WifiRegistryViewModel {
  final wifiCustomersStream = StreamController<List<WifiCustomerViewModel>>();

  WifiRegistryViewModel() {
    _getWifiCustomers();
  }

  void initState() {
    _getWifiCustomers();
  }

  void _getWifiCustomers() {
    FirebaseFirestore.instance
        .collection('wifiCustomers')
        .snapshots()
        .listen((data) {
      final wifiCustomers =
          data.docs.map((doc) => WifiCustomer.fromSnapshot(doc)).toList();
      final wifiCustomersViewModel = wifiCustomers
          .map((wifiCustomer) =>
              WifiCustomerViewModel(wifiCustomer: wifiCustomer))
          .toList();
      wifiCustomersStream.sink.add(wifiCustomersViewModel);
    });
  }

  Future<bool> addWifiCustomer(String name, String macAddress) async {
    final WifiCustomer wifiCustomer =
        WifiCustomer(name: name, macAddress: macAddress);
    bool _isSaved = false;
    try {
      FirebaseFirestore.instance
          .collection('wifiCustomers')
          .add(wifiCustomer.toMap());
      _isSaved = true;
    } on FirebaseException {
      return _isSaved;
    } catch (e) {
      return _isSaved;
    }
    return _isSaved;
  }
}
