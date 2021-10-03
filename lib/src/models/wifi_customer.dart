import 'package:cloud_firestore/cloud_firestore.dart';

class WifiCustomer {
  final String name;
  final String macAddress;
  const WifiCustomer({required this.name, required this.macAddress});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': macAddress,
    };
  }

  factory WifiCustomer.fromSnapshot(QueryDocumentSnapshot doc) {
    return WifiCustomer(
      name: doc['name'],
      macAddress: doc['address'],
    );
  }
}
