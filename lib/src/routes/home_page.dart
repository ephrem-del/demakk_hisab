import 'package:demakk_hisab/src/routes/contacts_page.dart';
import 'package:demakk_hisab/src/routes/wifi_registry_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'customers_list_page.dart';
import 'expense_list_page.dart';
import 'login_page.dart';
import 'new_orders_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
//  int _currentIndex = 0;
  final List _titles = ['Today\'s Orders', 'Customers', 'Expense'];
  String title = 'Todays\'s';
  bool _isSignedIn = false;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
    _tabController.addListener(_handleSelected);
    _isSignedOn();
  }

  void _handleSelected() {
    setState(() {
      title = _titles[_tabController.index];
    });
  }

  void _isSignedOn() {
    _isSignedIn = FirebaseAuth.instance.currentUser != null ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool isScrolled) {
            return [
              SliverPadding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, bottom: 10, top: 10),
                sliver: SliverAppBar(
                  leading: !_isSignedIn
                      ? IconButton(
                          icon: Icon(Icons.settings),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => LoginPage()));
                          },
                        )
                      : const SizedBox.shrink(),
                  automaticallyImplyLeading: false,
                  expandedHeight: 150,
                  elevation: 10,
                  shadowColor: Colors.black26,
                  forceElevated: true,
                  shape: const ContinuousRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  floating: true,
                  //pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: AnimatedContainer(
                      height: 68,
                      duration: const Duration(seconds: 1),
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                  bottom: TabBar(
                    unselectedLabelStyle: TextStyle(
                      fontSize: 16,
                    ),
                    padding: const EdgeInsets.only(left: 4, right: 4),
                    indicatorColor: Colors.white,
                    indicatorWeight: 5,
                    labelStyle: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600),
                    labelColor: Colors.white,
                    controller: _tabController,
                    tabs: const [
                      Tab(
                        text: 'Today\'s',
                      ),
                      Tab(
                        text: 'Customers',
                      ),
                      Tab(
                        text: 'Expense',
                      ),
                    ],
                  ),
                  actions: [
                    IconButton(
                      icon: Icon(Icons.supervisor_account_outlined),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ContactsPage(),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => WifiRegistryPage(),
                          ),
                        );
                      },
                      icon: Icon(Icons.wifi),
                    ),
                  ],
                ),
              )
            ];
          },
          body: DefaultTabController(
            length: 3,
            child: TabBarView(
              controller: _tabController,
              children: [
                NewOrdersPage(),
                const CustomersListPage(),
                const ExpenseListPage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
