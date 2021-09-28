import 'package:demakk_hisab/src/view_models/add_order_view_model.dart';
import 'package:demakk_hisab/src/view_models/customer_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddOrderPage extends StatefulWidget {
  final CustomerViewModel customer;
  const AddOrderPage({Key? key, required this.customer}) : super(key: key);

  @override
  _AddOrderPageState createState() => _AddOrderPageState();
}

class _AddOrderPageState extends State<AddOrderPage> {
  final newTypeController = TextEditingController();
  final newAmountController = TextEditingController();
  final newPricePerSingleController = TextEditingController();
  final newPaymentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AddOrderViewModel _addOrderViewModel = AddOrderViewModel();

  void _addOrder(context) async {
    // bool isAdded = false;

    if (_formKey.currentState!.validate()) {
      final name = widget.customer.customerName;
      final orderType = newTypeController.text;
      final ordAmount = int.parse(newAmountController.text);
      final double pps = double.parse(newPricePerSingleController.text);
      final paidAmount = int.parse(newPaymentController.text);
      final dateTime = DateTime.now();
      await _addOrderViewModel.addOrder(
          name, orderType, ordAmount, pps, paidAmount, widget.customer.id!);
      //if (isAdded) {
      Navigator.pop(context);
      //}
    }
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('ትዕዛዝ ማስገቢያ'),
      ),
      //backgroundColor: Colors.white12,
      body: Center(
        child: SingleChildScrollView(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: Container(
              color: Theme.of(context).primaryColor,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Text(
                      'ትዕዛዝ ማስገቢያ',
                      style: TextStyle(fontSize: 30),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          newType(),
                          const SizedBox(
                            height: 10,
                          ),
                          newAmount(),
                          const SizedBox(
                            height: 10,
                          ),
                          newPricePerSingle(),
                          const SizedBox(
                            height: 10,
                          ),
                          newPayment(),
                          const SizedBox(height: 70),
                          submitOrder()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //helper widgets
  Widget newType() {
    return SizedBox(
      width: 400,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('አይነት:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
          Opacity(
            opacity: 0.8,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: 200,
                color: Colors.white70,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: TextFormField(
                    controller: newTypeController,
                    validator: (value) {
                      if (value == null) {
                        return 'አይነት አስገባ';
                      }
                      if (value.isEmpty) {
                        return 'አይነት አስገባ';
                      }
                    },
                    decoration: const InputDecoration(hintText: 'የትዕዛዝ አይነት'),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget newAmount() {
    return SizedBox(
      width: 400,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'ብዛት:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          Opacity(
            opacity: 0.8,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: 200,
                color: Colors.white70,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: TextFormField(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    controller: newAmountController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null) {
                        return 'ብዛት አስገባ';
                      }
                      if (value.isEmpty) {
                        return 'ብዛት አስገባ';
                      }
                    },
                    decoration: const InputDecoration(hintText: 'ብዛት'),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget newPricePerSingle() {
    return SizedBox(
      width: 400,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'የአንዱ ዋጋ:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          Opacity(
            opacity: 0.8,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: 200,
                color: Colors.white70,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: TextFormField(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    controller: newPricePerSingleController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null) {
                        return 'የአንዱ ዋጋ አስገባ';
                      }
                      if (value.isEmpty) {
                        return 'የአንዱ ዋጋ አስገባ';
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: 'የአንዱ ዋጋ',
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget newPayment() {
    return SizedBox(
      width: 400,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'የተከፈለ:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          Opacity(
            opacity: 0.8,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: 200,
                color: Colors.white70,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: TextFormField(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    controller: newPaymentController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null) {
                        return 'የተከፈለ ብር አስገባ';
                      }
                      if (value.isEmpty) {
                        return 'የተከፈለ ብር አስገባ';
                      }
                    },
                    decoration: const InputDecoration(hintText: 'የተከፈለ ብር'),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget submitOrder() {
    return ElevatedButton(
      onPressed: () {
        _addOrder(context);
      },
      child: const Text(
        'ትዕዛዝ ጨምር',
        style: TextStyle(color: Colors.black),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
        foregroundColor: MaterialStateProperty.all(Colors.white),
      ),
    );
  }
}
