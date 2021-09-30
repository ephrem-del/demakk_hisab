import 'package:demakk_hisab/src/view_models/customer_view_model.dart';
import 'package:demakk_hisab/src/view_models/customers_list_view_model.dart';
import 'package:flutter/material.dart';

import 'add_customer_page.dart';
import 'customer_detail_page.dart';

class CustomersListPage extends StatefulWidget {
  const CustomersListPage({Key? key}) : super(key: key);

  @override
  State<CustomersListPage> createState() => _CustomersListPageState();
}

class _CustomersListPageState extends State<CustomersListPage> {
  late CustomersListPageViewModel _customersListPageVM;

  final TextEditingController _searchController = TextEditingController();

  List<CustomerViewModel> customersForSearch = [];
  List<CustomerViewModel> searchResult = [];

  @override
  void initState() {
    _customersListPageVM = CustomersListPageViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: PageStorageKey<String>('customers'),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => AddCustomerPage()));
        },
      ),
      body: StreamBuilder<List<CustomerViewModel>>(
        stream: _customersListPageVM.customersStream.stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('error: ${snapshot.error}');
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Text('Loading');
            default:
              if (!snapshot.hasData) {
                return Text('No data');
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
                            controller: _searchController,
                            onChanged: searchOperation,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            _searchController.clear();
                            searchResult.clear();
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
                child: searchResult.length != 0 ||
                        _searchController.text.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: searchResult.length,
                        itemBuilder: (context, index) {
                          CustomerViewModel _customerFromSearch =
                              searchResult[index];
                          return CustomerTile(customer: _customerFromSearch);
                        },
                      )
                    : ListView.builder(
                        itemCount: _customers.length,
                        itemBuilder: (context, index) {
                          final _customer = _customers[index];

                          return CustomerTile(customer: _customer);
                        }),
              ),
            ],
          );
        },
      ),
    );
  }

  void searchOperation(String searchText) {
    setState(() {});
    searchResult.clear();
    for (int i = 0; i < customersForSearch.length; i++) {
      CustomerViewModel data = customersForSearch[i];
      if (data.customerName.toLowerCase().contains(searchText.toLowerCase())) {
        searchResult.add(data);
      }
    }
  }
}

class CustomerTile extends StatelessWidget {
  final CustomerViewModel customer;
  const CustomerTile({Key? key, required this.customer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(color: Colors.black26, blurRadius: 6.0, offset: Offset(0, 2))
      ]),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black54, width: 2),
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(
                  offset: Offset(0, 2), blurRadius: 6.0, color: Colors.black26)
            ]),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CustomerDetailPage(customer: customer),
              ),
            );
          },
          splashColor: Colors.green,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      customer.customerName.replaceFirst(
                          customer.customerName[0],
                          customer.customerName[0].toUpperCase()),
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Payment Left:  ${customer.paymentLeft}",
                          //overflow: TextOverflow.fade,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Phone no: ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      customer.phoneNo,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
