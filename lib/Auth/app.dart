import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Admin/admin_menu.dart';
import 'package:frontend/Admin/admin_navigation.dart';
import 'package:frontend/Admin/admin_notifications.dart';
import 'package:frontend/Admin/admin_order.dart';
import 'package:frontend/Admin/admin_report.dart';
import 'package:frontend/Admin/admin_user.dart';
import 'package:frontend/Admin/order_components/active_orders.dart';
import 'package:frontend/Admin/order_components/order_history.dart';
import 'package:frontend/Auth/homepage.dart';
import 'package:frontend/Auth/login.dart';
import 'package:frontend/Pages/AboutUs.dart';
import 'package:frontend/Pages/Privacy.dart';
import 'package:frontend/Pages/Terms.dart';
import 'package:frontend/Pages/contactus.dart';
import 'package:frontend/Pages/order.dart';
import 'package:frontend/Pages/refundpolicy.dart';
import 'package:frontend/fetchdata.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  var currentMobIndex = 0;
  var currentWebIndex = 0;
  var expanded = false;
  var name = "";
  var phone = "";

  var mobile_pages = [
    Homepage(),
    Aboutus(),
    AdminUser(),
    AdminMenu(),
    AdminOrder(),
    AdminReport(),
    AdminNotifications()
  ];

  GetName() async {
    var res = await getUserName();
    var user = await getUserData();
    if (res.statusCode == 200) {
      setState(() {
        name = jsonDecode(res.body);
        if (user != null) {
          phone = user[0];
        }
      });
    }
  }

  Future<void> _handleMessage(RemoteMessage message) async {
    setState(() {});
    print(message);
  }

  setupMessage() async {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDKaN2OjtHsjyscLgTXjpSN2oBQgdreE9k",
        appId: "1:866320770453:android:2f1262b7673c196a7ac29c",
        messagingSenderId: "866320770453",
        projectId: "flutter-food-delivery-ap-5903b",
      ),
    );
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');
    FirebaseMessaging.onMessage.listen(_handleMessage);
  }

  @override
  void initState() {
    super.initState();
    GetName();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var web_pages = [
      Homepage(),
      Order(),
      AdminNavigation(AdminNavigation.new).callback(() => setState(() {
            currentWebIndex = 0;
          }))
    ];
    return SafeArea(
      child: Scaffold(
          key: _key,
          drawer: Drawer(
              backgroundColor: Colors.white,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  SizedBox(
                    height: 100,
                    child: DrawerHeader(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                              fontSize: 24, overflow: TextOverflow.ellipsis),
                        ),
                        Text(phone)
                      ],
                    )),
                  ),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text("Home"),
                    onTap: () {
                      Navigator.pop(context);
                      /*Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const Homepage()));*/
                      setState(() {
                        currentMobIndex = 0;
                      });
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: const Text("About Us"),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Aboutus()));
                    },
                  ),
                  /*ExpansionTile(
                    leading: Icon(Icons.admin_panel_settings),
                    childrenPadding: const EdgeInsets.only(left: 40),
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    title: Text("Admin"),
                    children: [
                      ListTile(
                        onTap: () {
                          setState(() {
                            currentMobIndex = 2;
                          });
                        },
                        title: Text("User"),
                      ),
                      ListTile(
                        onTap: () {
                          setState(() {
                            currentMobIndex = 3;
                          });
                        },
                        title: Text("Menu"),
                      ),
                      ExpansionTile(
                        title: Text("Orders"),
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
                          setState(() {
                            currentMobIndex = 5;
                          });
                        },
                        title: Text("Reports"),
                      ),
                      ListTile(
                        onTap: () {
                          setState(() {
                            currentMobIndex = 6;
                          });
                        },
                        title: Text("Notifications"),
                      )
                    ],
                  ),*/
                  ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Privacy()));
                    },
                    leading: const Icon(Icons.privacy_tip_outlined),
                    title: Text("Privacy Policy"),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Refundpolicy()));
                    },
                    leading: const Icon(Icons.receipt_outlined),
                    title: Text("Refund Policy"),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Terms()));
                    },
                    leading: const Icon(Icons.description_outlined),
                    title: Text("Terms And Condition"),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => ContactUs()));
                    },
                    leading: const Icon(Icons.description_outlined),
                    title: Text("Contact Us"),
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout_sharp),
                    title: const Text("Logout"),
                    onTap: () async {
                      //Navigator.pop(context);
                      /*Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Order()));*/
                      await deleteUserData();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => Login()),
                          (Route<dynamic> route) => false);
                    },
                  ),
                ],
              )),
          body: Row(children: [
            Visibility(
              visible: false,
              //visible: (width < 700 || currentWebIndex == 2) ? false : true,
              child: NavigationRail(
                  extended: expanded,
                  backgroundColor: Colors.white,
                  onDestinationSelected: (index) {
                    if (index != 0) {
                      setState(() {
                        currentWebIndex = index - 1;
                      });
                    }
                  },
                  labelType: !expanded
                      ? NavigationRailLabelType.all
                      : NavigationRailLabelType.none,
                  destinations: [
                    NavigationRailDestination(
                        padding: const EdgeInsets.only(bottom: 50),
                        icon: GestureDetector(
                            onTap: () {
                              setState(() {
                                expanded = !expanded;
                              });
                            },
                            child: Icon(Icons.menu)),
                        label: Text("")),
                    const NavigationRailDestination(
                        icon: Icon(Icons.home), label: Text("Home")),
                    const NavigationRailDestination(
                        icon: Icon(Icons.menu), label: Text("Order")),
                    const NavigationRailDestination(
                        icon: Icon(Icons.admin_panel_settings),
                        label: Text("Admin")),
                  ],
                  selectedIndex: currentWebIndex + 1),
            ),
            Expanded(
                child: width < 700
                    ? mobile_pages[currentMobIndex]
                    : web_pages[currentWebIndex])
          ])),
    );
  }
}
