import 'package:cloud_firestore/cloud_firestore.dart';

class Expense {
  final String title;
  final String description;
  final String amount;
  final DateTime dateAdded;
  final bool withVat;
  const Expense(
      {required this.title,
      required this.description,
      required this.amount,
      required this.dateAdded,
      this.withVat = true});

  factory Expense.fromSnapshot(QueryDocumentSnapshot snapshot) {
    return Expense(
      title: snapshot['title'],
      description: snapshot['description'],
      amount: snapshot['amount'],
      dateAdded: snapshot['dateAdded'].toDate(),
      withVat: snapshot['withVat'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'amount': amount,
      'dateAdded': dateAdded,
      'withVat': withVat
    };
  }
}
