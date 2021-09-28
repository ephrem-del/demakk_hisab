import 'package:cloud_firestore/cloud_firestore.dart';

class Expense {
  final String title;
  final String description;
  final String amount;
  final DateTime dateAdded;
  const Expense(
      {required this.title,
      required this.description,
      required this.amount,
      required this.dateAdded});

  factory Expense.fromSnapshot(QueryDocumentSnapshot snapshot) {
    return Expense(
        title: snapshot['title'],
        description: snapshot['description'],
        amount: snapshot['amount'],
        dateAdded: snapshot['dateAdded'].toDate());
  }

  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'description': this.description,
      'amount': this.amount,
      'dateAdded': this.dateAdded
    };
  }
}
