import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/components/filter.dart';
import 'package:frontend/components/menubar.dart';
import 'package:frontend/fetchdata.dart';

var data = [
  {"id": 1, "image": "assets/images/food1.webp", "name": "Pizza"},
  {"id": 2, "image": "assets/images/food2.webp", "name": "Pizza"},
  {"id": 3, "image": "assets/images/food3.jpeg", "name": "Pizza"},
  {"id": 4, "image": "assets/images/food4.jpeg", "name": "Pizza"},
  {"id": 5, "image": "assets/images/food1.webp", "name": "Pizza"},
  {"id": 6, "image": "assets/images/food2.webp", "name": "Pizza"},
  {"id": 7, "image": "assets/images/food3.jpeg", "name": "Pizza"},
  {"id": 8, "image": "assets/images/food4.jpeg", "name": "Pizza"},
  {"id": 9, "image": "assets/images/food1.webp", "name": "Pizza"},
  {"id": 10, "image": "assets/images/food2.webp", "name": "Pizza"},
  {"id": 11, "image": "assets/images/food3.jpeg", "name": "Pizza"},
  {"id": 12, "image": "assets/images/food4.jpeg", "name": "Pizza"},
  {"id": 13, "image": "assets/images/food1.webp", "name": "Pizza"},
  {"id": 14, "image": "assets/images/food2.webp", "name": "Pizza"},
  {"id": 15, "image": "assets/images/food3.jpeg", "name": "Pizza"},
  {"id": 16, "image": "assets/images/food4.jpeg", "name": "Pizza"}
];

class Menu extends StatefulWidget {
  const Menu(this.category, {super.key});
  final category;

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> with SingleTickerProviderStateMixin {
  var filterValue = "";
  late TabController _tabController;
  var filter = ["Filter", "", "", ""];
  var categoryIds = [];
  var categoryIndex = 0;

  getCategoryData() async {
    var res = await getCategory();
    if (res != null) {
      setState(() {
        categoryIds = res as List;

        _tabController = TabController(vsync: this, length: categories.length);
        if (widget.category != "") {
          _tabController.index = categories.indexOf(widget.category);
        }

        for (var i = 0; i < categoryIds.length; i++) {
          if (categoryIds[i]["name"] == widget.category) categoryIndex = i;
        }
      });
    }
  }

  callback(val) {
    setState(() {
      filter = List<String>.from(val);
    });
  }

  @override
  void initState() {
    super.initState();
    getCategoryData();
    //_tabController = TabController(vsync: this, length: categories.length);
    //_tabController.index = categories.indexOf(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return categoryIds.length > 0
        ? Container(
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: filter.map((item) {
                    return item != ""
                        ? Padding(
                            padding: EdgeInsets.only(top: 10, left: 10),
                            child: GestureDetector(
                              onTap: () {
                                if (item == "Filter") {
                                  showCupertinoModalPopup(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return new Filter(
                                            filter: filter, callback);
                                      });
                                } else {
                                  setState(() {
                                    filter[filter.indexOf(item)] = "";
                                  });
                                }
                              },
                              child: Container(
                                //width: width * 0.2,
                                height: 30,
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(left: 10, right: 10),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(item),
                                    Icon(
                                      item == "Filter"
                                          ? Icons.filter_alt
                                          : Icons.cancel,
                                      color: Colors.grey,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Container();
                  }).toList()),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        child: IntrinsicHeight(
                          child: NavigationRail(
                              selectedIndex: 0,
                              onDestinationSelected: (value) {
                                setState(() {
                                  categoryIndex = value;
                                });
                              },
                              backgroundColor: Colors.white,
                              destinations:
                                  categoryIds.asMap().entries.map((item) {
                                return NavigationRailDestination(
                                    icon: Container(
                                      color: categoryIndex == item.key
                                          ? Color.fromARGB(255, 194, 192, 192)
                                          : Colors.white,
                                      padding: EdgeInsets.all(5),
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              item.value["image"],
                                              width: 100,
                                              height: 50,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Text(item.value["name"])
                                        ],
                                      ),
                                    ),
                                    label: Text(""));
                              }).toList()),
                        ),
                      ),
                      Expanded(
                        key: Key(filter.toString()),
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
                          color: Color.fromARGB(193, 251, 249, 249),
                          key: Key(categoryIndex.toString()),
                          child: ListOfItems(
                            filter: filter,
                            category: categoryIds[categoryIndex]["_id"],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        : Container();
    /*categoryIds.length > 0
        ? DefaultTabController(
            length: categories.length,
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Color.fromARGB(37, 243, 248, 248),
                  toolbarHeight: 0,
                  bottom: PreferredSize(
                    //preferredSize: Size.fromWidth(width),
                    preferredSize: Size(width, 60),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          /*Row(
                  children: [
                    Container(
                        height: 50,
                        padding: const EdgeInsets.all(10),
                        child: TextButton(
                            style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all<Color>(
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
                            child: Row(
                              children: [
                                const Text(
                                  "Filter",
                                  style: TextStyle(color: Colors.white),
                                ),
                                const Icon(
                                  Icons.filter_list,
                                  size: 20,
                                  color: Colors.white,
                                ),
                                Visibility(
                                  visible: width < 700 ? false : true,
                                  child: const Text(
                                    "Filter",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              ],
                            ))),
                    Visibility(
                        visible: filterValue != "" ? true : false,
                        child: TextButton(
                            style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all<Color>(
                                    Colors.green)),
                            onPressed: () {},
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    filterValue,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          filterValue = "";
                                        });
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        child: const Icon(
                                          Icons.cancel_outlined,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ))
                                ])))
                  ],
                ),*/
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              height: 60,
                              child: TabBar(
                                onTap: (index) {
                                  if (_tabController.index <
                                          categories.length -
                                              categoryIds.length &&
                                      categoryIds.length > 0) {
                                    setState(() {
                                      _tabController.index =
                                          _tabController.previousIndex;
                                    });
                                  }
                                },
                                labelColor: Colors.blue,
                                dividerHeight: 0,
                                indicatorColor: Colors.white,
                                isScrollable: true,
                                labelPadding: EdgeInsets.only(
                                    left: width * 0.01, right: width * 0.01),
                                labelStyle: width >= 700
                                    ? TextStyle(
                                        fontSize: 15,
                                      )
                                    : null,
                                controller: _tabController,
                                tabAlignment: TabAlignment.center,
                                overlayColor: WidgetStateProperty.all<Color>(
                                    Colors.white),
                                //isScrollable: true,
                                splashFactory: NoSplash.splashFactory,
                                tabs: categories
                                    .map((e) => Tab(
                                        child: e == "Filter"
                                            ? GestureDetector(
                                                onTap: () {
                                                  showCupertinoModalPopup(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return const Filter(
                                                                Filter.new)
                                                            .callback((val) =>
                                                                setState(() {
                                                                  filterValue =
                                                                      val;
                                                                }));
                                                      });
                                                },
                                                child: Container(
                                                  width: width * 0.2,
                                                  height: 30,
                                                  alignment: Alignment.center,
                                                  //padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.grey),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(e),
                                                      Icon(
                                                        Icons.filter_alt,
                                                        color: Colors.grey,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : (e == "value"
                                                ? Visibility(
                                                    visible: (e == "value" &&
                                                            filterValue !=
                                                                "") ||
                                                        (e != "value"),
                                                    child: Container(
                                                      //width: width * 0.2,
                                                      height: 30,
                                                      alignment:
                                                          Alignment.center,
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  Colors.grey),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Text(e == "value"
                                                          ? filterValue
                                                          : e),
                                                    ),
                                                  )
                                                : Container(
                                                    width: width * 0.2,
                                                    height: 30,
                                                    alignment: Alignment.center,
                                                    //padding: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.grey),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Text(e == "value"
                                                        ? filterValue
                                                        : e),
                                                  ))))
                                    .toList(),
                              ),
                            ),
                          ),
                        ]),
                  ),
                ),
                body: TabBarView(
                    controller: _tabController,
                    children: categories.asMap().entries.map((e) {
                      return ListOfItems(
                          category: categoryIds[max(
                                  0,
                                  e.key -
                                      (categories.length - categoryIds.length))]
                              ["_id"]);
                    }).toList())),
          )
        : Container();*/
  }
}
