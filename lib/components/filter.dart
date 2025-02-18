import 'dart:math';

import 'package:flutter/material.dart';

class Filter extends StatefulWidget {
  const Filter(
    this.callback, {
    super.key,
    this.filter,
  });
  final Function callback;
  final filter;

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  /*var data = [
    {"id": 0, "item": "Time zone"},
    {"id": 1, "item": "Popular"},
    {"id": 2, "item": "Non Veg"},
    {"id": 3, "item": "Special"},
    {"id": 4, "item": "Price: low to high"},
    {"id": 5, "item": "Price: High to low"}
  ];*/
  var filters = [];
  var data = [
    {
      "Sort by": [
        "Popular",
        "Special",
        "Price: Low to high",
        "Price: High to low",
      ]
    },
    {
      "Time Zone": ["Evening time", "Dinner time", "Mid-night time"]
    },
    {
      "Veg/Non Veg": ["Pure veg", "Non veg"]
    }
  ];

  @override
  void initState() {
    super.initState();
    setState(() {
      for (var obj in widget.filter) {
        filters.add(obj as String);
      }
    });
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Material(
      color: Colors.white,
      child: Container(
        width: min(width, 600),
        height: height * 0.8,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Filter"),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.cancel))
                ],
              ),
            ),
            Divider(),
            Expanded(
              //height: 400,
              child: Row(
                children: [
                  NavigationRail(
                    minWidth: width * 0.3,
                    useIndicator: false,
                    backgroundColor: Color.fromARGB(49, 158, 158, 158),
                    destinations: data.asMap().entries.map((item) {
                      var ind = item.key;

                      return NavigationRailDestination(
                          icon: Container(
                              width: 100,
                              padding: EdgeInsets.only(left: 10, right: 10),
                              color: ind == currentIndex
                                  ? Color.fromARGB(49, 158, 158, 158)
                                  : null,
                              alignment: Alignment.centerLeft,
                              child: Text(item.value.keys.first)),
                          label: Text(""));
                    }).toList(),
                    selectedIndex: currentIndex,
                    onDestinationSelected: (index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: data.map((items) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: items.values.first.map((item) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (filters[currentIndex + 1] == item) {
                                    filters[currentIndex + 1] = "";
                                  } else {
                                    filters[currentIndex + 1] = item;
                                  }
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(5),
                                color: filters.contains(item)
                                    ? Color.fromARGB(255, 226, 221, 221)
                                    : Colors.white,
                                child: Row(
                                  children: [
                                    Icon(Icons.circle_outlined),
                                    Text("$item")
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      }).toList()[currentIndex],
                    ),
                  )
                ],
              ),
            ),
            Row(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: GestureDetector(
                      onTap: () {
                        widget.callback(["Filter", "", "", ""]);
                        Navigator.of(context).pop();
                      },
                      child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10),
                          child: Text("Clear All"))),
                ),
                Expanded(
                  child: GestureDetector(
                      onTap: () {
                        widget.callback(filters);
                        Navigator.of(context).pop();
                      },
                      child: Container(
                          alignment: Alignment.center,
                          color: Colors.blue,
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Apply",
                            style: TextStyle(color: Colors.white),
                          ))),
                ),
              ],
            )
          ],
        ),
      ),
    );
    /*Container(
      height: height * 0.8,
      width: min(width, 600),
      padding: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      child: Column(
        children: [
          const Text(
            "Filter",
            style: TextStyle(
                fontSize: 25,
                color: Colors.grey,
                decoration: TextDecoration.none),
          ),
          const Divider(
            color: Colors.grey,
          ),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: data.asMap().entries.map((item) {
                return GestureDetector(
                    onTap: () {
                      setState(() {
                        currentIndex = item.key;
                        widget.callback(item.value["item"]);
                      });
                    },
                    child: Container(
                        color: currentIndex == item.key
                            ? Colors.green
                            : Colors.white,
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Icon(Icons.circle_sharp,
                                color: item.key == currentIndex
                                    ? Colors.white
                                    : Colors.grey),
                            Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  item.value["item"].toString(),
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: item.key == currentIndex
                                          ? Colors.white
                                          : Colors.grey,
                                      decoration: TextDecoration.none),
                                )),
                          ],
                        )));
              }).toList())
        ],
      ),
    );*/
  }
}
