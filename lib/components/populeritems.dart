import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/components/itemdetail.dart';
import 'package:frontend/components/menubar.dart';
import 'package:frontend/fetchdata.dart';

class Populeritems extends StatefulWidget {
  const Populeritems({super.key});

  @override
  State<Populeritems> createState() => _PopuleritemsState();
}

class _PopuleritemsState extends State<Populeritems> {
  var data = [];
  getData() async {
    var res = await getPopulerItems();
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
              child: Text(
                "Populer Now",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
              )),
          SingleChildScrollView(
            padding: EdgeInsets.only(left: 20, bottom: 20),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: data.map((item) {
                return Container(
                    width: min(width * 0.4, 250),
                    margin: EdgeInsets.only(right: 20),
                    alignment: Alignment.center,
                    child: Item(id: item["id"]));
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class Item extends StatefulWidget {
  const Item({super.key, this.id});
  final id;

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  var data = {};
  getData() async {
    var res = await getMenuitemsById(widget.id);
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
    return !data.isEmpty
        ? Material(
            elevation: 2,
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            child: PopulerItem(
              item: data,
            ),
          )
        : Container();
  }
}

class PopulerItem extends StatelessWidget {
  const PopulerItem({super.key, this.item});
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
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            child: Image.network(
                width: min(250, width * 0.4),
                height: min(200, width * 0.35),
                fit: BoxFit.cover,
                item["image"]),
          ),
        ),
        Container(
          padding: EdgeInsets.all(max(10, width * 0.025 - 10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: min(100, width * 0.2),
                    child: Text(
                      item["name"],
                      maxLines: 1,
                      style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w500),
                    ),
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
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text(
                          "stock:${(item["stock"] / 2).toInt()}",
                          maxLines: 1,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.blue,
                            ),
                            Text(" " + item["rating"].toString())
                          ],
                        )
                      ])),
                  InkWell(
                    onTap: () async {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return PopScope(
                                canPop: false,
                                child:
                                    Center(child: CircularProgressIndicator()));
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
