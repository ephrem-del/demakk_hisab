import 'package:demakk_hisab/src/view_models/authentication_view_model.dart';
import 'package:demakk_hisab/src/view_models/supplier_detail_list_view_model.dart';
import 'package:demakk_hisab/src/view_models/supplier_detail_view_model.dart';
import 'package:demakk_hisab/src/view_models/supplier_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'add_supplier_detail_page.dart';

class SupplierDetailPage extends StatefulWidget {
  final SupplierViewModel supplier;
  const SupplierDetailPage({required this.supplier, Key? key})
      : super(key: key);

  @override
  State<SupplierDetailPage> createState() => _SupplierDetailPageState();
}

class _SupplierDetailPageState extends State<SupplierDetailPage> {
  late SupplierDetailListViewModel _supplierDetailListViewModel;
  final TextEditingController newPriceController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  final TextEditingController userNameController = TextEditingController();

  final TextEditingController pinController = TextEditingController();

  final AuthenticationViewModel _authenticationViewModel =
      AuthenticationViewModel();

  @override
  void initState() {
    super.initState();
    _supplierDetailListViewModel =
        SupplierDetailListViewModel(supplier: widget.supplier);
  }

  void delete(context, SupplierDetailViewModel supplierDetailViewModel) {
    final String userName = userNameController.text;
    final String pin = pinController.text;
    if (_formKey2.currentState!.validate()) {
      bool authenticated =
          _authenticationViewModel.authenticate(userName, int.parse(pin));
      if (authenticated) {
        _supplierDetailListViewModel.delete(supplierDetailViewModel);
        userNameController.clear();
        pinController.clear();
        Navigator.pop(context);
      }
    }
  }

  void edit(context, SupplierDetailViewModel supplierDetailViewModel) {
    final String newPrice = newPriceController.text;
    final String userName = userNameController.text;
    final String pin = pinController.text;
    if (_formKey.currentState!.validate()) {
      bool authenticated =
          _authenticationViewModel.authenticate(userName, int.parse(pin));
      if (authenticated) {
        _supplierDetailListViewModel.edit(supplierDetailViewModel, newPrice);
        newPriceController.clear();
        userNameController.clear();
        pinController.clear();
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.supplier.supplierName.replaceFirst(
                  widget.supplier.supplierName[0],
                  widget.supplier.supplierName[0].toUpperCase()) +
              '\'s Item\'s',
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddSupplierDetailPage(supplier: widget.supplier),
            ),
          );
        },
      ),
      body: StreamBuilder<List<SupplierDetailViewModel>>(
        stream: _supplierDetailListViewModel.supplierDetailListStream.stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('error: ${snapshot.error}');
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Text('Loading . . .');
            default:
              if (!snapshot.hasData) {
                return Text('No data');
              }
          }
          final _supplierDetails = snapshot.data;
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                _supplierDetails == null || _supplierDetails.length == 0
                    ? SizedBox.shrink()
                    : Divider(
                        thickness: 2,
                      ),
                Expanded(
                  child: ListView.builder(
                      itemCount: _supplierDetails!.length,
                      itemBuilder: (context, index) {
                        final _supplier = _supplierDetails[index];
                        return DetailTile(
                            supplierDetail: _supplier,
                            onDelete: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Form(
                                      key: _formKey2,
                                      child: SimpleDialog(
                                        title: Text('Delete Item'),
                                        children: [
                                          Text(
                                              'Are you sure you want to delete ${_supplier.item} item'),
                                          TextFormField(
                                            controller: userNameController,
                                            decoration: InputDecoration(
                                              label: Text('Username'),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Username required';
                                              }
                                            },
                                          ),
                                          TextFormField(
                                            controller: pinController,
                                            decoration: InputDecoration(
                                              label: Text('PIN'),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'PIN required';
                                              }
                                            },
                                          ),
                                          ButtonBar(
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  userNameController.clear();
                                                  pinController.clear();
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  delete(context, _supplier);
                                                },
                                                child: Text('Delete'),
                                              )
                                            ],
                                          )
                                        ],
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                      ),
                                    );
                                  });
                            },
                            onEdit: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Form(
                                      key: _formKey,
                                      child: SimpleDialog(
                                        title: Text('Edit Price'),
                                        children: [
                                          Text(
                                              'Previous price: ${_supplier.price}'),
                                          TextFormField(
                                            decoration: InputDecoration(
                                              label: Text('New Price'),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'New Price required';
                                              }
                                            },
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            controller: newPriceController,
                                          ),
                                          TextFormField(
                                            controller: userNameController,
                                            decoration: InputDecoration(
                                              label: Text('Username'),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Username required';
                                              }
                                            },
                                          ),
                                          TextFormField(
                                            controller: pinController,
                                            decoration: InputDecoration(
                                              label: Text('PIN'),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'PIN required';
                                              }
                                            },
                                          ),
                                          ButtonBar(
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  newPriceController.clear();
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  edit(context, _supplier);
                                                },
                                                child: Text('Edit'),
                                              ),
                                            ],
                                          )
                                        ],
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 25, vertical: 10),
                                      ),
                                    );
                                  });
                            });
                      }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class DetailTile extends StatelessWidget {
  final SupplierDetailViewModel supplierDetail;
  Function onDelete;
  Function onEdit;
  DetailTile(
      {required this.supplierDetail,
      required this.onDelete,
      required this.onEdit,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                supplierDetail.item,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        onEdit();
                      },
                      icon: Icon(Icons.edit)),
                  IconButton(
                      onPressed: () {
                        onDelete();
                      },
                      icon: Icon(Icons.delete)),
                ],
              )
            ],
          ),
          Text(
            supplierDetail.price,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          Divider(
            thickness: 2,
          ),
        ],
      ),
    );
  }
}
