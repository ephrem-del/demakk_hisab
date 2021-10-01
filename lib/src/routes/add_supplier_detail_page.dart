import 'package:demakk_hisab/src/view_models/add_supplier_detail_view_model.dart';
import 'package:demakk_hisab/src/view_models/supplier_view_model.dart';
import 'package:flutter/material.dart';

class AddSupplierDetailPage extends StatefulWidget {
  final SupplierViewModel supplier;
  AddSupplierDetailPage({required this.supplier, Key? key}) : super(key: key);

  @override
  State<AddSupplierDetailPage> createState() => _AddSupplierDetailPageState();
}

class _AddSupplierDetailPageState extends State<AddSupplierDetailPage> {
  final TextEditingController _itemController = TextEditingController();

  final TextEditingController _priceController = TextEditingController();

  final AddSupplierDetailViewModel _addSupplierDetailViewModel =
      AddSupplierDetailViewModel();

  final _formKey = GlobalKey<FormState>();

  addDetail(context) async {
    final String item = _itemController.text;
    final String price = _priceController.text;
    if (_formKey.currentState!.validate()) {
      final isSaved = await _addSupplierDetailViewModel.addSupplierDetail(
          item, price, widget.supplier);
      if (isSaved == true) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add detail to ${widget.supplier.supplierName}'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _itemController,
                decoration: InputDecoration(label: Text('Item / Service')),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'item or service required';
                  }
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(
                  label: Text('Price'),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'price required';
                  }
                },
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  addDetail(context);
                },
                child: Text('Add Detail'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
