import 'package:demakk_hisab/src/view_models/customer_all_order_view_model.dart';
import 'package:demakk_hisab/src/view_models/customer_today_orders_view_model.dart';
import 'package:demakk_hisab/src/view_models/customer_view_model.dart';
import 'package:demakk_hisab/src/view_models/customers_weekly_orders_view_model.dart';
import 'package:demakk_hisab/src/view_models/order_view_model.dart';
import 'package:demakk_hisab/src/widgets/order_tile.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'add_order_page.dart';

class CustomerDetailPage extends StatelessWidget {
  final CustomerViewModel customer;
  const CustomerDetailPage({Key? key, required this.customer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _pages = <Widget>[
      _TodayBody(customer: customer),
      _WeeklyBody(customer: customer),
      _AllBody(customer: customer)
    ];
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => launch('tel:${customer.phoneNo}'),
          child: Icon(Icons.call),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text(customer.customerName),
          bottom: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width, 50),
            child: const TabBar(
              labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              unselectedLabelStyle: TextStyle(
                fontSize: 18,
              ),
              tabs: [
                Tab(
                  text: 'ዛሬ',
                ),
                Tab(
                  text: 'ሳምንታዊ',
                ),
                Tab(
                  text: 'ጠቅላላ',
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddOrderPage(customer: customer),
                    ),
                  );
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: TabBarView(
              children: _pages,
            )),
      ),
    );
  }
}

class _AllBody extends StatefulWidget {
  final CustomerViewModel customer;
  const _AllBody({Key? key, required this.customer}) : super(key: key);

  @override
  State<_AllBody> createState() => _AllBodyState();
}

class _AllBodyState extends State<_AllBody> {
  late CustomerAllOrderViewModel _customerAllOrderViewModel;

  @override
  void initState() {
    _customerAllOrderViewModel =
        CustomerAllOrderViewModel(customer: widget.customer);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<OrderViewModel>>(
        stream: _customerAllOrderViewModel.allOrdersStream.stream,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Text('Loading . . .');
            default:
              if (!snapshot.hasData) {
                return const Text('No data');
              }
          }
          final orders = snapshot.data!;
          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, int index) {
              final OrderViewModel order = orders[index];
              return OrderTile(
                order: order,
                onCancel: () {},
              );
            },
          );
        });
  }
}

class _WeeklyBody extends StatefulWidget {
  final CustomerViewModel customer;
  const _WeeklyBody({Key? key, required this.customer}) : super(key: key);

  @override
  State<_WeeklyBody> createState() => _WeeklyBodyState();
}

class _WeeklyBodyState extends State<_WeeklyBody> {
  late CustomersWeeklyOrdersViewModel _customersWeeklyOrdersViewModel;

  @override
  void initState() {
    _customersWeeklyOrdersViewModel =
        CustomersWeeklyOrdersViewModel(customer: widget.customer);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<OrderViewModel>>(
      stream: _customersWeeklyOrdersViewModel.weeklyStream.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Text('Loading . . .');
          default:
            if (!snapshot.hasData) {
              return Text('No data');
            }
        }
        final _orders = snapshot.data!;
        return ListView.builder(
          itemCount: _orders.length,
          itemBuilder: (context, index) {
            final _order = _orders[index];
            return OrderTile(
              order: _order,
              onCancel: () {
                _customersWeeklyOrdersViewModel.cancelOrder(_order);
              },
              cancelButtonNotVisible: false,
            );
          },
        );
      },
    );
  }
}

class _TodayBody extends StatefulWidget {
  final CustomerViewModel customer;
  const _TodayBody({Key? key, required this.customer}) : super(key: key);

  @override
  State<_TodayBody> createState() => _TodayBodyState();
}

class _TodayBodyState extends State<_TodayBody> {
  late CustomerTodayOrderViewModel _customerTodayOrderViewModel;

  @override
  void initState() {
    _customerTodayOrderViewModel =
        CustomerTodayOrderViewModel(customer: widget.customer);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<OrderViewModel>>(
      stream: _customerTodayOrderViewModel.todayOrdersStream.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Text('Loading . . .');
          default:
            if (!snapshot.hasData) {
              return Text('No data');
            }
        }
        final _orders = snapshot.data!;
        return ListView.builder(
          itemCount: _orders.length,
          itemBuilder: (context, index) {
            final _order = _orders[index];
            return OrderTile(
                order: _order,
                onCancel: () {
                  _customerTodayOrderViewModel.cancelOrder(_order);
                },
                cancelButtonNotVisible: false);
          },
        );
      },
    );
  }
}
