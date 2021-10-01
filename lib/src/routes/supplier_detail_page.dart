import 'package:demakk_hisab/src/view_models/supplier_detail_list_view_model.dart';
import 'package:demakk_hisab/src/view_models/supplier_detail_view_model.dart';
import 'package:demakk_hisab/src/view_models/supplier_view_model.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    _supplierDetailListViewModel =
        SupplierDetailListViewModel(supplier: widget.supplier);
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
                Container(
                  height: 2,
                  color: Color(0xFF000000),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: _supplierDetails!.length,
                      itemBuilder: (context, index) {
                        final _supplier = _supplierDetails[index];
                        return DetailTile(supplierDetail: _supplier);
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
  const DetailTile({required this.supplierDetail, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 2)),
      ),
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
                  IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
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
          )
        ],
      ),
    );
  }
}
