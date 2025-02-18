import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/Admin/admin_menu.dart';
import 'package:frontend/Admin/admin_notifications.dart';
import 'package:frontend/Admin/admin_order.dart';
import 'package:frontend/Admin/admin_report.dart';
import 'package:frontend/Admin/admin_user.dart';
import 'package:frontend/Admin/order_components/active_orders.dart';
import 'package:frontend/Admin/order_components/order_history.dart';
import 'package:frontend/Pages/order.dart';
import 'package:frontend/components/filter.dart';
import 'package:frontend/components/menubar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  int currentIndex = 0;
  var filterValue = "";
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      /*drawer: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(child: Text("Drawer")),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text("Profile"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const Home()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.playlist_add_circle),
                title: const Text("Order"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Order()));
                },
              ),
              ExpansionTile(
                leading: Icon(Icons.admin_panel_settings),
                childrenPadding: const EdgeInsets.only(left: 40),
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                title: Text("Admin"),
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => AdminUser()));
                    },
                    title: Text("User"),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => AdminMenu()));
                    },
                    title: Text("Menui"),
                  ),
                  ExpansionTile(
                    title: Text("Order s"),
                    children: [
                      ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ActiveOrders()));
                        },
                        title: Text("Active Orders"),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => OrderHistory()));
                        },
                        title: Text("Order history"),
                      ),
                    ],
                  ),
                  ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AdminOrder()));
                      },
                      title: Text("Order")),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AdminReport()));
                    },
                    title: Text("Reports"),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AdminNotifications()));
                    },
                    title: Text("Notifications"),
                  )
                ],
              )
            ],
          )),*/
      body: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: const Column(children: [
            /* Visibility(
              visible: width < 700 ? true : false,
              child: Container(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Column(children: [
                  /* Material(
                      elevation: 3,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      child: const TextField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            hintText: "Search",
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none),
                      )),*/
                  /*Row(
                    children: [
                      Container(
                          margin: const EdgeInsets.only(
                              top: 10, bottom: 10, right: 10),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all<Color>(
                                          Colors.green)),
                              onPressed: () {
                                showCupertinoModalPopup(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const Filter(Filter.new)
                                          .callback((val) => setState(() {
                                                filterValue = val;
                                              }));
                                    });
                              },
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.tune,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    "Filter",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ))),
                      Visibility(
                          visible: filterValue != "" ? true : false,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all<Color>(
                                          Colors.green)),
                              onPressed: () {},
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      filterValue,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            filterValue = "";
                                          });
                                        },
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(left: 10),
                                          child: const Icon(
                                            Icons.cancel_outlined,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ))
                                  ])))
                    ],
                  )*/
                ]),
              ),
            ),*/
            //const Expanded(child: Menubar()),
          ])),
    );
  }
}
