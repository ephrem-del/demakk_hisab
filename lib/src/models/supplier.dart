import 'package:cloud_firestore/cloud_firestore.dart';

class Supplier {
  final String name;
  final String phoneNumber;
  final String comment;
  Supplier(
      {required this.name, required this.phoneNumber, required this.comment});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'comment': comment,
    };
  }

  factory Supplier.fromSnapshot(QueryDocumentSnapshot doc) {
    return Supplier(
      name: doc['name'],
      phoneNumber: doc['phoneNumber'],
      comment: doc['comment'],
    );
  }
}
