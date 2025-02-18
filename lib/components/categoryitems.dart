import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/fetchdata.dart';

class CategpryItems extends StatefulWidget {
  const CategpryItems(this.callback, {super.key});
  final Function callback;

  @override
  State<CategpryItems> createState() => _CategpryItemsState();
}

class _CategpryItemsState extends State<CategpryItems> {
  var data = [];
  getData() async {
    var res = await getCategory();
    if (res != null) {
      setState(() {
        data = res;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Categories",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (data.length > 0) widget.callback(data[0]["name"], 1);
                    },
                    child: Text(
                      "Menu",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              )),
          SingleChildScrollView(
            padding: EdgeInsets.only(left: 20, bottom: 20),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: data.map((item) {
                return GestureDetector(
                  onTap: () {
                    widget.callback(item["name"], 1);
                  },
                  child: Container(
                      width: min(250, width * 0.3),
                      height: min(200, width * 0.25),
                      margin: EdgeInsets.only(right: 20),
                      child: Stack(children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            width: width * 0.3,
                            height: width * 0.25,
                            item["image"],
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          padding: EdgeInsets.all(10),
                          child: Text(
                            item["name"],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: width > 800 ? 25 : 15,
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      ])),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
