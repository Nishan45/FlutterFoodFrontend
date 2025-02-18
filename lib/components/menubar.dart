import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/components/categoryitems.dart';
import 'package:frontend/components/filter.dart';
import 'package:frontend/components/homemenuitems.dart';
import 'package:frontend/components/imageSlider.dart';
import 'package:frontend/components/itemdetail.dart';
import 'package:frontend/components/populeritems.dart';
import 'package:frontend/fetchdata.dart';

var serverUrl = dotenv.env["SERVER_URL"];
var urlAddToCart = "$serverUrl/AddToCart";

var categories = ["Dinner", "Breakfast", "Snacks", "Beverages"];

var data = [
  {"id": 1, "image": "assets/images/food1.webp", "name": "Pizza"},
  {"id": 2, "image": "assets/images/food2.webp", "name": "Pizza"},
  {"id": 3, "image": "assets/images/food3.jpeg", "name": "Pizza"},
  {"id": 4, "image": "assets/images/food4.jpeg", "name": "Pizza"},
  {"id": 5, "image": "assets/images/food1.webp", "name": "Pizza"},
  {"id": 6, "image": "assets/images/food2.webp", "name": "Pizza"},
  {"id": 7, "image": "assets/images/food3.jpeg", "name": "Pizza"},
  {"id": 8, "image": "assets/images/food4.jpeg", "name": "Pizza"}
];

class Menubar extends StatefulWidget {
  const Menubar(this.callback, {super.key});
  final Function callback;

  @override
  State<Menubar> createState() => _MenubarState();
}

class _MenubarState extends State<Menubar> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: DefaultTabController(
            length: categories.length, child: CustomTabBar(widget.callback)));
  }
}

class CustomTabBar extends StatefulWidget {
  const CustomTabBar(this.callback, {super.key});
  final Function callback;

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with TickerProviderStateMixin {
  late ScrollController _scrollController;
  late TabController _tabController;
  double offset = 0.0;
  var filterValue = "";

  @override
  void initState() {
    super.initState();

    _tabController =
        TabController(vsync: this, length: categories.length, initialIndex: 0);
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          offset = _scrollController.offset;
        });
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: width <= 800
          ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Imageslider(),
                  CategpryItems(widget.callback),
                  Populeritems(),
                  //for (var category in categories) Homemenuitems(widget.callback, category: category),
                ],
              ),
            )
          : IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Imageslider(),
                  CategpryItems(widget.callback),
                  Populeritems(),
                  //for (var category in categories) Homemenuitems(widget.callback, category: category),
                ],
              ),
            ),
    );
  }
}

/*
NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            expandedHeight: width < 700 ? width * 0.4 + 12 : height * 0.3,
            forceElevated: innerBoxIsScrolled,
            flexibleSpace: const FlexibleSpaceBar(
              background: Imageslider(),
            ),
          ),
          SliverAppBar(
            primary: false,
            elevation: 0,
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
            foregroundColor: Colors.white,
            automaticallyImplyLeading: false,
            expandedHeight: 0,
            pinned: true,
            floating: true,
            //snap: true,
            forceElevated: innerBoxIsScrolled,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: Row(children: [
                Row(
                  children: [
                    Container(
                        height: 60,
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
                                const Icon(
                                  Icons.tune,
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
                                        ),
                                      ))
                                ])))
                  ],
                ),
                Expanded(
                  child: Container(
                    height: 60,
                    child: TabBar(
                      padding: EdgeInsets.all(0),
                      isScrollable: true,
                      labelPadding: EdgeInsets.only(
                          left: width * 0.05,
                          right: width * 0.05,
                          bottom: 0,
                          top: 0),
                      labelStyle: width >= 700
                          ? TextStyle(
                              fontSize: 15,
                            )
                          : null,
                      //controller: _tabController,
                      tabAlignment: TabAlignment.center,
                      overlayColor:
                          WidgetStateProperty.all<Color>(Colors.white),
                      //isScrollable: true,
                      splashFactory: NoSplash.splashFactory,
                      tabs: categories.map((e) => Tab(text: e)).toList(),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ];
      },
      body: TabBarView(
          //controller: _tabController,

          children: categories
              .map((e) => ListOfItems(
                    category: e,
                  ))
              .toList()),
    );
*/
class ListOfItems extends StatefulWidget {
  const ListOfItems({super.key, this.category, this.filter});
  final category;
  final filter;

  @override
  State<ListOfItems> createState() => _ListOfItemsState();
}

class _ListOfItemsState extends State<ListOfItems>
    with AutomaticKeepAliveClientMixin {
  var items = [];
  final time = DateTime.now().toUtc().toIso8601String();
  late ScrollController _scrollController;
  var page = 0;
  var limit = 6;

  getMenuitems(category) async {
    var new_data =
        await getMenuitemsData(page, limit, category, time, widget.filter);
    setState(() {
      items = [...items, ...new_data];
    });
  }

  _scrollListner() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        page = page + 1;
      });
      getMenuitems(widget.category);
    }
  }

  @override
  void initState() {
    super.initState();
    getMenuitems(widget.category);
    _scrollController = new ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListner);
  }

  @override
  Widget build(BuildContext context) {
    int count = min(4, MediaQuery.of(context).size.width ~/ 150);
    var width = MediaQuery.of(context).size.width;
    if (width < 1200 && count >= 4) {
      count--;
    }
    if (width < 900 && count >= 3) {
      count--;
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: count, childAspectRatio: 0.8),
      itemCount: items.length,
      controller: _scrollController,
      itemBuilder: (context, index) {
        final item = items[index];
        return Items(item: item);
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class Items extends StatelessWidget {
  const Items({super.key, this.item});
  final item;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return IgnorePointer(
      ignoring: item["stock"] <= 1,
      child: Container(
        padding: EdgeInsets.all(min(30, width * 0.02)),
        child: Material(
          elevation: 2,
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Itemdetail(item)));
                  },
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    child: Image.network(
                      width: width * 0.4,
                      item["image"],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          item["name"],
                          maxLines: 1,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                    child: Text(
                                  "${item["price"]}₹",
                                  maxLines: 1,
                                )),
                                Flexible(
                                    child: Text(
                                  item["stock"] <= 1
                                      ? "Unavailable"
                                      : "stock:${(item["stock"] / 2).toInt()}",
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: item["stock"] <= 1
                                        ? Colors.red
                                        : Colors.grey,
                                  ),
                                )),
                              ],
                            ),
                            Visibility(
                              visible: item["stock"] > 1,
                              child: GestureDetector(
                                onTap: () async {
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return PopScope(
                                          canPop: false,
                                          child: Center(
                                              child:
                                                  CircularProgressIndicator()),
                                        );
                                      });
                                  await uploadData({
                                    "userId": "userId",
                                    "itemId": item["_id"]
                                  }, urlAddToCart)
                                      .then((val) {
                                    int code = val.statusCode;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(code == 200
                                                ? "Items added to cart"
                                                : "Items already exists")));
                                  });

                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  margin: EdgeInsets.only(top: 10),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.blue),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: const Text(
                                    "Add",
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
