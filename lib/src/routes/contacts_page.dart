import 'package:demakk_hisab/src/routes/add_contact_page.dart';
import 'package:demakk_hisab/src/view_models/contacts_view_model.dart';
import 'package:demakk_hisab/src/view_models/customer_view_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = <Widget>[_Customers(), _Suppliers()];
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
        return ListView.builder(
            itemCount: _customers.length,
            itemBuilder: (context, index) {
              final _customer = _customers[index];
              return ContactTile(customer: _customer);
            });
      },
    );
  }
}

class _Suppliers extends StatefulWidget {
  const _Suppliers({Key? key}) : super(key: key);

  @override
  __SuppliersState createState() => __SuppliersState();
}

class __SuppliersState extends State<_Suppliers> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Suppliers'),
    );
  }
}

class ContactTile extends StatelessWidget {
  final CustomerViewModel customer;
  const ContactTile({required this.customer, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(customer.customerName),
      subtitle: Text(customer.phoneNo),
      trailing: IconButton(
        onPressed: () => launch('tel:${customer.phoneNo}'),
        icon: Icon(Icons.call),
      ),
    );
  }
}
