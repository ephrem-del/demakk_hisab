import 'package:demakk_hisab/src/routes/add_contact_page.dart';
import 'package:demakk_hisab/src/routes/supplier_detail_page.dart';
import 'package:demakk_hisab/src/view_models/contacts_view_model.dart';
import 'package:demakk_hisab/src/view_models/customer_view_model.dart';
import 'package:demakk_hisab/src/view_models/supplier_view_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = <Widget>[const _Customers(), _Suppliers()];
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => AddContactPage()));
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text('Contacts'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Customers',
              ),
              Tab(
                text: 'Suppliers',
              )
            ],
          ),
        ),
        body: TabBarView(
          children: _pages,
        ),
      ),
    );
  }
}

class _Customers extends StatefulWidget {
  const _Customers({Key? key}) : super(key: key);

  @override
  __CustomersState createState() => __CustomersState();
}

class __CustomersState extends State<_Customers> {
  late ContactsViewModel _contactsViewModel;

  final TextEditingController _customerSearchController =
      TextEditingController();

  List<CustomerViewModel> customersForSearch = [];
  List<CustomerViewModel> customerSearchResult = [];

  @override
  void initState() {
    _contactsViewModel = ContactsViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CustomerViewModel>>(
      stream: _contactsViewModel.customersStream.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('error: ${snapshot.error}');
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: Text('Loading . . .'));
          default:
            if (!snapshot.hasData) {
              return const Center(child: Text('No data'));
            }
        }
        final List<CustomerViewModel> _customers = snapshot.data!;
        customersForSearch = _customers;
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.teal,
                    width: 3.0,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 2, 8, 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.search),
                              hintText: 'Search . . .',
                              contentPadding:
                                  EdgeInsets.fromLTRB(10, 15, 10, 5),
                              border: InputBorder.none),
                          controller: _customerSearchController,
                          onChanged: customerSearchOperation,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          _customerSearchController.clear();
                          customerSearchResult.clear();
                          setState(() {});
                        },
                        icon: Icon(Icons.clear),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Flexible(
              child: customerSearchResult.length != 0 ||
                      _customerSearchController.text.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: customerSearchResult.length,
                      itemBuilder: (context, index) {
                        CustomerViewModel _customerFromSearch =
                            customerSearchResult[index];
                        return ContactTile(customer: _customerFromSearch);
                      },
                    )
                  : ListView.builder(
                      itemCount: _customers.length,
                      itemBuilder: (context, index) {
                        final _customer = _customers[index];
                        return ContactTile(customer: _customer);
                      }),
            ),
          ],
        );
      },
    );
  }

  void customerSearchOperation(String searchText) {
    setState(() {});
    customerSearchResult.clear();
    for (int i = 0; i < customersForSearch.length; i++) {
      CustomerViewModel data = customersForSearch[i];
      if (data.customerName.toLowerCase().contains(searchText.toLowerCase())) {
        customerSearchResult.add(data);
      }
    }
  }
}

class _Suppliers extends StatefulWidget {
  const _Suppliers({Key? key}) : super(key: key);

  @override
  __SuppliersState createState() => __SuppliersState();
}

class __SuppliersState extends State<_Suppliers> {
  late ContactsViewModel _contactsViewModel;

  final TextEditingController _supplierSearchController =
      TextEditingController();

  List<SupplierViewModel> suppliersForSearch = [];
  List<SupplierViewModel> supplierSearchResult = [];

  void initState() {
    _contactsViewModel = ContactsViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<SupplierViewModel>>(
      stream: _contactsViewModel.suppliersStream.stream,
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
        final List<SupplierViewModel> _suppliers = snapshot.data!;
        suppliersForSearch = _suppliers;
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.teal,
                    width: 3.0,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 2, 8, 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.search),
                              hintText: 'Search . . .',
                              contentPadding:
                                  EdgeInsets.fromLTRB(10, 15, 10, 5),
                              border: InputBorder.none),
                          controller: _supplierSearchController,
                          onChanged: supplierSearchOperation,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          _supplierSearchController.clear();
                          supplierSearchResult.clear();
                          setState(() {});
                        },
                        icon: Icon(Icons.clear),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Flexible(
              child: supplierSearchResult.length != 0 ||
                      _supplierSearchController.text.isNotEmpty
                  ? ListView.builder(
                      itemCount: supplierSearchResult.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        SupplierViewModel _supplierFromSearch =
                            supplierSearchResult[index];
                        return ContactSupplierTile(
                            supplier: _supplierFromSearch);
                      },
                    )
                  : ListView.builder(
                      itemCount: _suppliers.length,
                      itemBuilder: (context, index) {
                        final supplier = _suppliers[index];
                        return ContactSupplierTile(supplier: supplier);
                      }),
            ),
          ],
        );
      },
    );
  }

  void supplierSearchOperation(String searchText) {
    setState(() {});
    supplierSearchResult.clear();
    for (int i = 0; i < suppliersForSearch.length; i++) {
      SupplierViewModel data = suppliersForSearch[i];
      if (data.supplierName.toLowerCase().contains(searchText.toLowerCase())) {
        supplierSearchResult.add(data);
      }
    }
  }
}

class ContactTile extends StatelessWidget {
  final CustomerViewModel customer;
  const ContactTile({required this.customer, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        customer.customerName.replaceFirst(
          customer.customerName[0],
          customer.customerName[0].toUpperCase(),
        ),
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        customer.phoneNo,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: IconButton(
        onPressed: () => launch('tel:${customer.phoneNo}'),
        icon: Icon(Icons.call),
      ),
    );
  }
}

class ContactSupplierTile extends StatelessWidget {
  final SupplierViewModel supplier;
  const ContactSupplierTile({required this.supplier, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: true,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => SupplierDetailPage(supplier: supplier),
          ),
        );
      },
      title: Text(
        supplier.supplierName.replaceFirst(
            supplier.supplierName[0], supplier.supplierName[0].toUpperCase()),
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Align(
        alignment: Alignment.topLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              supplier.supplierPhoneNumber,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              supplier.supplierComment,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
      trailing: IconButton(
        onPressed: () => launch('tel:${supplier.supplierPhoneNumber}'),
        icon: Icon(Icons.call),
      ),
    );
  }
}
