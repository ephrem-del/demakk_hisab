import 'package:demakk_hisab/src/view_models/wifi_customer_view_model.dart';
import 'package:demakk_hisab/src/view_models/wifi_registry_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:wakelock/wakelock.dart';

class WifiRegistryPage extends StatefulWidget {
  const WifiRegistryPage({Key? key}) : super(key: key);

  @override
  State<WifiRegistryPage> createState() => _WifiRegistryPageState();
}

class _WifiRegistryPageState extends State<WifiRegistryPage> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _macAddressController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  late final WifiRegistryViewModel _wifiRegistryViewModel;

  @override
  void initState() {
    _wifiRegistryViewModel = WifiRegistryViewModel();
    super.initState();
    Wakelock.enable();
  }

  _addCustomer(context) async {
    final String name = _nameController.text;
    final String macAddress = _macAddressController.text;
    if (_formKey.currentState!.validate()) {
      bool isSaved =
          await _wifiRegistryViewModel.addWifiCustomer(name, macAddress);
      if (isSaved) {
        _nameController.clear();
        _macAddressController.clear();
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wifi Registry'),
        centerTitle: true,
      ),
      body: StreamBuilder<List<WifiCustomerViewModel>>(
        stream: _wifiRegistryViewModel.wifiCustomersStream.stream,
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
          final wifiCustomers = snapshot.data;
          return ListView.builder(
            itemCount: wifiCustomers!.length,
            itemBuilder: (context, index) {
              final customer = wifiCustomers[index];
              return _Tile(customer: customer);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return Form(
                  key: _formKey,
                  child: SimpleDialog(
                    title: Text('Add Wifi Customer'),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          label: Text('Name'),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Name required';
                          }
                        },
                      ),
                      TextFormField(
                        controller: _macAddressController,
                        decoration: InputDecoration(
                          label: Text('macAddress'),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'macAddress required';
                          }
                        },
                      ),
                      ButtonBar(
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              _addCustomer(context);
                            },
                            child: Text('Add'),
                          )
                        ],
                      )
                    ],
                  ),
                );
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class _Tile extends StatefulWidget {
  final WifiCustomerViewModel customer;
  bool countdownStart;
  _Tile({required this.customer, this.countdownStart = false, Key? key})
      : super(key: key);

  @override
  State<_Tile> createState() => _TileState();
}

class _TileState extends State<_Tile> {
  int timeInSeconds = 0;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.customer.name.replaceFirst(
          widget.customer.name[0],
          widget.customer.name[0].toUpperCase(),
        ),
      ),
      subtitle: Text('Mac Address: ${widget.customer.macAddress}'),
      trailing: SizedBox(
        width: 150,
        child: widget.countdownStart
            ? Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        widget.countdownStart = false;
                      });
                    },
                    icon: Icon(Icons.clear),
                  ),
                  Expanded(
                    child: CountdownTimer(
                      endTime: (DateTime.now().millisecondsSinceEpoch +
                          1000 * timeInSeconds),
                    ),
                  ),
                ],
              )
            : TextButton(
                onPressed: () {
                  final DateTime now = DateTime.now();
                  showTimePicker(
                          context: context,
                          initialTime:
                              TimeOfDay(hour: now.hour, minute: now.minute))
                      .then((value) {
                    if (value != null) {
                      int hourDifference = value.hour - now.hour;
                      int minuteDifference = value.minute - now.minute;
                      int hourInSeconds = hourDifference * 60 * 60;
                      int minuteInSeconds = minuteDifference * 60;
                      setState(() {
                        timeInSeconds = hourInSeconds + minuteInSeconds;
                        widget.countdownStart = true;
                      });
                    }
                  });
                },
                child: Text('Start'),
              ),
      ),
    );
  }
}
