import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/components/itemdetail.dart';
import 'package:frontend/components/menubar.dart';
import 'package:frontend/fetchdata.dart';

class Homemenuitems extends StatefulWidget {
  const Homemenuitems(this.callback, {super.key, this.category});
  final category;
  final Function callback;
  @override
  State<Homemenuitems> createState() => _HomemenuitemsState();
}

class _HomemenuitemsState extends State<Homemenuitems> {
  var data = [];
  final time = DateTime.now().toUtc().toIso8601String();
  var page = 0;
  var limit = 6;
  getData() async {
    var res = await getMenuitemsData(page, limit, widget.category, time);
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.category,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w600),
                ),
                GestureDetector(
                  onTap: () {
                    widget.callback(widget.category, 1);
                  },
                  child: Text(
                    "See all",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.w600),
                  ),
                )
              ],
            )),
        SingleChildScrollView(
          padding: EdgeInsets.all(5),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: data.map((item) {
              return Padding(
                padding: EdgeInsets.all(10),
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  elevation: 2,
                  child: Container(
                      width: width * 0.4,

                      //decoration: BoxDecoration(border: Border.all()),
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      child: HomeItem(item: item)),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class HomeItem extends StatelessWidget {
  const HomeItem({super.key, this.item});
  final item;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Itemdetail(item)));
          },
          child: Image.network(
              width: width * 0.35,
              height: width * 0.35,
              fit: BoxFit.cover,
              item["image"]),
        ),
        Container(
          padding: EdgeInsets.all(max(0, width * 0.025 - 10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item["name"],
                    maxLines: 1,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "${item["price"]}₹",
                    maxLines: 1,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      child: Text(
                    "stock:${(item["stock"] / 2).toInt()}",
                    maxLines: 1,
                    style: const TextStyle(color: Colors.grey),
                  )),
                  InkWell(
                    onTap: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Center(child: CircularProgressIndicator());
                          });
                      await uploadData(
                              {"userId": "userId", "itemId": item["_id"]},
                              urlAddToCart)
                          .then((val) {
                        int code = val.statusCode;
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
