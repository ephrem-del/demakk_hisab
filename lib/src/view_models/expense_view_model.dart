import 'package:demakk_hisab/src/models/model.dart';
import 'package:demakk_hisab/src/utils/time_converter.dart';

class ExpenseViewModel {
  final Expense expense;
  const ExpenseViewModel({required this.expense});

  factory ExpenseViewModel.fromSnapshot(Expense expense) {
    return ExpenseViewModel(expense: expense);
  }

  String get title {
    return expense.title;
  }

  String get description {
    return expense.description;
  }

  String get totalAmount {
    return expense.amount;
  }

  String get withoutVat {
    if (expense.withVat == true) {
      final _total = int.parse(expense.amount);
      final _withoutVat = _total / 1.15;
      return _withoutVat.toStringAsFixed(2);
    }
    return expense.amount;
  }

  String get vat {
    if (expense.withVat == true) {
      final _total = int.parse(expense.amount);
      final _withoutVat = _total / 1.15;
      final _vat = _total - _withoutVat;
      return _vat.toStringAsFixed(2);
    }
    return '';
  }

  bool get withVat {
    return expense.withVat;
  }

  String get dateAdded {
    final hour = expense.dateAdded.toLocal().hour;
    final converted = TimeConverter(hour: hour).convertedTime;
    if (expense.dateAdded.day == DateTime.now().day &&
        expense.dateAdded.month == DateTime.now().month &&
        expense.dateAdded.year == DateTime.now().year) {
      return 'Today @ $converted : ${expense.dateAdded.minute}';
    } else if (!(DateTime.now().difference(expense.dateAdded) >
        Duration(days: 1))) {
      return 'Yesterday $converted : ${expense.dateAdded.minute}';
    } else {
      switch (expense.dateAdded.weekday) {
        case 1:
          return 'Monday $converted : ${expense.dateAdded.minute}  ${expense.dateAdded.toLocal().day}/${expense.dateAdded.toLocal().month}/${expense.dateAdded.toLocal().year}';
        case 2:
          return 'Tuesday $converted : ${expense.dateAdded.minute}  ${expense.dateAdded.toLocal().day}/${expense.dateAdded.toLocal().month}/${expense.dateAdded.toLocal().year}';
        case 3:
          return 'Wednesday $converted : ${expense.dateAdded.minute}  ${expense.dateAdded.toLocal().day}/${expense.dateAdded.toLocal().month}/${expense.dateAdded.toLocal().year}';
        case 4:
          return 'Thursday $converted : ${expense.dateAdded.minute}  ${expense.dateAdded.toLocal().day}/${expense.dateAdded.toLocal().month}/${expense.dateAdded.toLocal().year}';
        case 5:
          return 'Friday $converted : ${expense.dateAdded.minute}  ${expense.dateAdded.toLocal().day}/${expense.dateAdded.toLocal().month}/${expense.dateAdded.toLocal().year}';
        case 6:
          return 'Saturday $converted : ${expense.dateAdded.minute}  ${expense.dateAdded.toLocal().day}/${expense.dateAdded.toLocal().month}/${expense.dateAdded.toLocal().year}';
        case 7:
          return 'Sunday $converted : ${expense.dateAdded.minute}  ${expense.dateAdded.toLocal().day}/${expense.dateAdded.toLocal().month}/${expense.dateAdded.toLocal().year}';
        default:
          return expense.dateAdded.toLocal().toString();
      }
    }
    //return expense.dateAdded.toString();
  }
}
