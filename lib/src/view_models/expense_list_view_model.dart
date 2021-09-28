import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demakk_hisab/src/models/model.dart';

import 'expense_view_model.dart';

class ExpenseListViewModel {
  final expenseStream = StreamController<List<ExpenseViewModel>>();

  ExpenseListViewModel() {
    _getExpense();
  }

  void initState() {
    _getExpense();
  }

  _getExpense() {
    FirebaseFirestore.instance
        .collection('expense')
        .orderBy('dateAdded', descending: true)
        .snapshots()
        .listen((data) {
      final _expenses =
          data.docs.map((doc) => Expense.fromSnapshot(doc)).toList();
      final _expenseViewModels = _expenses
          .map((expense) => ExpenseViewModel(expense: expense))
          .toList();
      expenseStream.sink.add(_expenseViewModels);
    });
  }

  void dispose() {
    expenseStream.close();
  }
}
