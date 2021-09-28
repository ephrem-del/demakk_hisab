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
          return ListView.builder(
              itemCount: _customers.length,
              itemBuilder: (context, index) {
                final _customer = _customers[index];
                return CustomerTile(customer: _customer);
              });
        },
      ),
    );
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
                      customer.customerName,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "ቀሪ ክፍያ:  ${customer.paymentLeft}",
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
                      'ስልክ ቁጥር: ',
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
