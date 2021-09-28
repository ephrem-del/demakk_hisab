import 'package:demakk_hisab/src/view_models/expense_list_view_model.dart';
import 'package:demakk_hisab/src/view_models/expense_view_model.dart';
import 'package:flutter/material.dart';

import 'add_expense_page.dart';

class ExpenseListPage extends StatefulWidget {
  const ExpenseListPage({Key? key}) : super(key: key);

  @override
  State<ExpenseListPage> createState() => _ExpenseListPageState();
}

class _ExpenseListPageState extends State<ExpenseListPage> {
  late ExpenseListViewModel _expenseListVM;

  @override
  void initState() {
    super.initState();
    _expenseListVM = ExpenseListViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: PageStorageKey<String>('expense'),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddExpensePage()));
        },
      ),
      body: StreamBuilder<List<ExpenseViewModel>>(
        stream: _expenseListVM.expenseStream.stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          switch (snapshot.connectionState) {
            // case ConnectionState.waiting:
            //   return const Center(
            //     child: Text('Loading . . .'),
            //   );
            default:
              if (!snapshot.hasData) {
                return const Center(
                  child: Text('No data'),
                );
              }
          }
          final List<ExpenseViewModel> _expenses = snapshot.data!;
          return ListView.builder(
              itemCount: _expenses.length,
              itemBuilder: (context, index) {
                final _expense = _expenses[index];
                return ExpenseTile(expense: _expense);
              });
        },
      ),
    );
  }
}

class ExpenseTile extends StatelessWidget {
  final ExpenseViewModel expense;
  const ExpenseTile({Key? key, required this.expense}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black54, width: 2),
        boxShadow: const [
          BoxShadow(
              color: Colors.black26, offset: Offset(0, 2), blurRadius: 6.0)
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ExpenseListTile(title: 'ርዕስ: ', content: expense.title),
            _ExpenseListTile(title: 'የብር መጠን: ', content: expense.amount),
            _ExpenseListTile(title: 'የወጪ ዝርዝር: ', content: expense.description),
            _ExpenseListTile(title: '', content: expense.dateAdded)
          ],
        ),
      ),
    );
  }
}

class _ExpenseListTile extends StatelessWidget {
  final String title;
  final String content;
  const _ExpenseListTile({Key? key, required this.title, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          // SizedBox(
          //   width: 15,
          // ),
          const Spacer(
            flex: 1,
          ),
          Expanded(
            flex: 5,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                content,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
