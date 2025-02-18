import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Admin/admin_menu.dart';
import 'package:frontend/Admin/admin_notifications.dart';
import 'package:frontend/Admin/admin_order.dart';
import 'package:frontend/Admin/admin_report.dart';
import 'package:frontend/Admin/admin_user.dart';
import 'package:frontend/Auth/login.dart';
import 'package:frontend/Pages/AboutUs.dart';
import 'package:frontend/Pages/Privacy.dart';
import 'package:frontend/Pages/Terms.dart';
import 'package:frontend/Pages/cart.dart';
import 'package:frontend/Pages/contactus.dart';
import 'package:frontend/Pages/home.dart';
import 'package:frontend/Pages/menu.dart';
import 'package:frontend/Pages/order.dart';
import 'package:frontend/Pages/refundpolicy.dart';
import 'package:frontend/components/footer.dart';
import 'package:frontend/components/menubar.dart';
import 'package:frontend/components/searchpage.dart';
import 'package:frontend/fetchdata.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}
// ignore_for_file: prefer_const_constructors

class _HomepageState extends State<Homepage> {
  int currentPageIndex = 0;
  int currentDrawerIndex = 0;
  int currentWebIndex = 0;
  ScrollController _controller = ScrollController();

  var category = "";

  updateCategoryAndPageindex(value, index) {
    setState(() {
      category = value;
    });
    setState(() {
      currentPageIndex = index;
      currentWebIndex = index;
    });
  }

  updatePageindex(index) {
    setState(() {
      currentWebIndex = index;
    });
  }

  scrollToTop() {
    setState(() {
      _controller.animateTo(
        _controller.position.minScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 200),
      );
    });
  }

  var termelements = [
    "About Us",
    "Contact Us",
    "Pricay Policy",
    "Terms & Conditions",
    "Refund Policy"
  ];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: width <= 800
            ? AppBar(
                backgroundColor: Colors.green,
                surfaceTintColor: Colors.white,
                toolbarHeight: width > 800
                    ? 100
                    : currentPageIndex == 0
                        ? min(width * 0.18 + 15 + 20 + 56, 200)
                        : 56 + 10,
                flexibleSpace: Container(
                  alignment: Alignment.center,
                  width: width,
                  padding: EdgeInsets.all(10),
                  height: currentPageIndex == 0
                      ? min(width * 0.18 + 15 + 20 + 56, 200)
                      : 56 + 10,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Visibility(
                              visible: width < 700 ? true : false,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: GestureDetector(
                                    onTap: () {
                                      Scaffold.of(context).openDrawer();
                                    },
                                    child: Icon(Icons.menu)),
                              ),
                            ),
                            Visibility(
                              visible: (currentPageIndex == 1),
                              child: Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(right: 34),
                                  child: Material(
                                      elevation: 2,
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      child: GestureDetector(
                                        onTap: () async {
                                          await showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Searchpage();
                                              });
                                        },
                                        child: Container(
                                          height: width * 0.1,
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.only(
                                              left: width * 0.04),
                                          decoration: BoxDecoration(

                                              //border: Border.all(),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Text(
                                            "Search",
                                            style: TextStyle(
                                                fontSize: width * 0.04),
                                          ),
                                        ),
                                      )),
                                ),
                              ),
                            ),
                            Visibility(
                                visible: (currentPageIndex == 2),
                                child: Text(
                                  "My Cart",
                                  style: TextStyle(fontSize: 18),
                                ))
                          ],
                        ),
                        Visibility(
                          visible: (currentPageIndex == 0),
                          child: Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Text(
                                "Welcome",
                                style: TextStyle(fontSize: width * 0.03),
                              )),
                        ),
                        Visibility(
                          visible: (currentPageIndex == 0 && width <= 800),
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              "What would you like to order!",
                              maxLines: 1,
                              style: TextStyle(fontSize: width * 0.05),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: (currentPageIndex == 0),
                          child: Container(
                            alignment: Alignment.center,
                            padding:
                                EdgeInsets.only(left: 10, right: 10, top: 10),
                            child: Material(
                                elevation: 2,
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                child: GestureDetector(
                                  onTap: () async {
                                    await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Searchpage();
                                        });
                                  },
                                  child: Container(
                                    width: min(double.infinity, 800),
                                    height: min(60, width * 0.1),
                                    alignment: Alignment.centerLeft,
                                    padding:
                                        EdgeInsets.only(left: width * 0.04),
                                    decoration: BoxDecoration(
                                        //border: Border.all(),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text(
                                      "Search",
                                      style: TextStyle(
                                          fontSize: min(width * 0.04, 20)),
                                    ),
                                  ),
                                )),
                          ),
                        ),
                        Visibility(
                          //visible: width >= 700 ? true : false,
                          visible: false,
                          child: Expanded(
                            child: NavigationBar(
                              destinations: const [
                                NavigationDestination(
                                    icon: Icon(Icons.home), label: "Home"),
                                NavigationDestination(
                                    icon: Icon(Icons.menu), label: "Menu"),
                                NavigationDestination(
                                    icon: Icon(Icons.shopping_cart),
                                    label: "Cart")
                              ],
                              indicatorColor: Color.fromARGB(255, 33, 208, 243),
                              selectedIndex: currentPageIndex,
                              backgroundColor: Colors.white,
                              onDestinationSelected: (int index) {
                                setState(() {
                                  category = "";
                                });
                                setState(() {
                                  currentPageIndex = index;
                                  currentWebIndex = index;
                                });
                              },
                            ),
                          ),
                        ),
                      ]),
                ),
              )
            : null,
        /*AppBar(
              flexibleSpace: Image.asset(
                  color: Colors.black.withOpacity(0.5),
                  "images/FoodBackgroundImage.png",
                  fit: BoxFit.cover,
                  colorBlendMode: BlendMode.darken),
              toolbarHeight: 200,
              backgroundColor: Colors.blue,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: width * 0.2,
                    alignment: Alignment.center,
                    child: Text(
                      "BECC",
                      style: TextStyle(color: Colors.white, fontSize: 50),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Material(
                          elevation: 2,
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          child: GestureDetector(
                            onTap: () async {
                              await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Searchpage();
                                  });
                            },
                            child: Container(
                              height: 45,
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: width * 0.04),
                              decoration: BoxDecoration(

                                  //border: Border.all(),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                "Search",
                                style: TextStyle(),
                              ),
                            ),
                          )),
                    ),
                  ),
                  Container(
                    width: width * 0.4,
                    padding: EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                currentPageIndex = 0;
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                "Home",
                                style: TextStyle(
                                    color: currentPageIndex == 0
                                        ? Colors.black
                                        : Colors.white,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                currentPageIndex = 1;
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                "Menu",
                                style: TextStyle(
                                    color: currentPageIndex == 1
                                        ? Colors.black
                                        : Colors.white,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                currentPageIndex = 2;
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                "Cart",
                                style: TextStyle(
                                    color: currentPageIndex == 2
                                        ? Colors.black
                                        : Colors.white,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () async {
                                await deleteUserData();
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => Login()),
                                    (Route<dynamic> route) => false);
                              },
                              child: Text(
                                "Logout",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),*/

        bottomNavigationBar: Visibility(
          visible: width <= 800 ? true : false,
          child: NavigationBar(
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home), label: "Home"),
              NavigationDestination(icon: Icon(Icons.menu), label: "Menu"),
              NavigationDestination(
                  icon: Icon(Icons.shopping_cart), label: "Cart"),
            ],
            indicatorColor: Colors.green,
            selectedIndex: currentPageIndex,
            backgroundColor: Color.fromARGB(255, 116, 246, 122),
            onDestinationSelected: (int index) {
              setState(() {
                category = "";
              });
              setState(() {
                currentPageIndex = index;
                currentWebIndex = index;
              });
            },
          ),
        ),
        body: width > 800
            ? SingleChildScrollView(
                controller: _controller,
                child: Container(
                  height: 2 * height + 200,
                  //height: double.infinity,
                  child: Column(
                    children: [
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.5),
                                    BlendMode.darken),
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  "FoodBackgroundImage.png",
                                ))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: width * 0.2,
                              height: 200,
                              alignment: Alignment.center,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    currentPageIndex = 0;
                                    currentWebIndex = 0;
                                  });
                                },
                                child: Text(
                                  "BECC",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 50),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: currentWebIndex >= 3,
                              child: Container(
                                width: width * 0.2,
                                height: 200,
                                alignment: Alignment.center,
                                child: Text(
                                  termelements[max(currentWebIndex - 3, 0)],
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 30),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: currentWebIndex < 3,
                              child: Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Material(
                                      elevation: 2,
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      child: GestureDetector(
                                        onTap: () async {
                                          await showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Searchpage();
                                              });
                                        },
                                        child: Container(
                                          height: 45,
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.only(
                                              left: width * 0.04),
                                          decoration: BoxDecoration(

                                              //border: Border.all(),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Text(
                                            "Search",
                                            style: TextStyle(),
                                          ),
                                        ),
                                      )),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: currentWebIndex < 3,
                              child: Container(
                                width: width * 0.4,
                                padding: EdgeInsets.only(left: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            currentPageIndex = 0;
                                            currentWebIndex = 0;
                                          });
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Home",
                                            style: TextStyle(
                                                color: currentPageIndex == 0
                                                    ? Colors.black
                                                    : Colors.white,
                                                fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            currentPageIndex = 1;
                                            currentWebIndex = 1;
                                          });
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Menu",
                                            style: TextStyle(
                                                color: currentPageIndex == 1
                                                    ? Colors.black
                                                    : Colors.white,
                                                fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            currentPageIndex = 2;
                                            currentWebIndex = 2;
                                          });
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Cart",
                                            style: TextStyle(
                                                color: currentPageIndex == 2
                                                    ? Colors.black
                                                    : Colors.white,
                                                fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () async {
                                          await deleteUserData();
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Login()),
                                                  (Route<dynamic> route) =>
                                                      false);
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Logout",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                            alignment: Alignment.center,
                            padding: width > 800
                                ? EdgeInsets.only(
                                    left: width * 0.15, right: width * 0.15)
                                : EdgeInsets.all(0),
                            child: [
                              Menubar(updateCategoryAndPageindex),
                              Menu(category),
                              Cart(),
                              Aboutus(),
                              ContactUs(),
                              Privacy(),
                              Terms(),
                              Refundpolicy()
                            ][currentWebIndex]),
                      ),
                      Footer(updatePageindex, scrollToTop)
                    ],
                  ),
                ),
              )
            : [
                Menubar(updateCategoryAndPageindex),
                Menu(category),
                Cart(),
              ][currentPageIndex]);
  }
}
