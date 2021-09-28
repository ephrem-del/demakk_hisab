import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demakk_hisab/src/models/model.dart';

class AddExpenseViewModel {
  Future<bool> addExpense(
      String title, String description, String amount) async {
    bool isSaved = false;
    final String _title = title;
    final String _description = description;
    final String _amount = amount;
    final DateTime _dateAdded = DateTime.now();
    final Expense _expense = Expense(
        title: _title,
        description: _description,
        amount: _amount,
        dateAdded: _dateAdded);
    try {
      await FirebaseFirestore.instance
          .collection('expense')
          .add(_expense.toMap());
      isSaved = true;
    } on FirebaseException catch (e) {
    } catch (e) {}
    return isSaved;
  }
}
