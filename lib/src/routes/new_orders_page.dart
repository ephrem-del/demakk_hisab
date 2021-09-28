import 'package:demakk_hisab/src/view_models/new_orders_view_model.dart';
import 'package:demakk_hisab/src/view_models/order_view_model.dart';
import 'package:demakk_hisab/src/widgets/order_tile.dart';
import 'package:flutter/material.dart';

class NewOrdersPage extends StatefulWidget {
  NewOrdersPage({Key? key}) : super(key: key);

  @override
  State<NewOrdersPage> createState() => _NewOrdersPageState();
}

class _NewOrdersPageState extends State<NewOrdersPage> {
  late NewOrdersViewModel _newOrdersVM;

  @override
  void initState() {
    _newOrdersVM = NewOrdersViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: PageStorageKey<String>('New'),
        bottomSheet: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Container(
            color: Theme.of(context).primaryColor,
            //margin: const EdgeInsets.only(bottom: 30),
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'ጠቅላላ የዛሬ ገቢ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  StreamBuilder(
                    stream: _newOrdersVM.totalTodayStream.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('0 ብር');
                      }
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Text('0 ብር');
                        default:
                          if (!snapshot.hasData) {
                            return Text('0 ብር');
                          }
                      }
                      final totalToday = snapshot.data!;
                      return Text(
                        '$totalToday ብር',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
        body: StreamBuilder<List<OrderViewModel>>(
          stream: _newOrdersVM.newOrdersStream.stream,
          builder: (context, snapshot) {
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
            final _orders = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: ListView.builder(
                  itemCount: _orders.length,
                  itemBuilder: (context, index) {
                    final OrderViewModel order = _orders[index];
                    return OrderTile(
                      order: order,
                      onCancel: () {},
                    ); //OrderTile(order: order);
                  }),
            );
          },
        ));
  }
}
