import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/Pages/orderprogress.dart';
import 'package:frontend/components/menubar.dart';
import 'package:frontend/fetchdata.dart';
import 'package:item_count_number_button/item_count_number_button.dart';

class Itemdetail extends StatefulWidget {
  const Itemdetail(this.item, {super.key});
  final item;
  @override
  State<Itemdetail> createState() => _ItemdetailState();
}

class _ItemdetailState extends State<Itemdetail> {
  num number = 1;
  var plate = "Full";

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    var item = widget.item;
    var stock = item["stock"];
    var discription = item["description"];

    return SafeArea(
      child: Scaffold(
        //appBar: null,
        body: Container(
          padding: EdgeInsets.only(
              left: width >= 800 ? width * 0.1 : 0,
              right: width >= 800 ? width * 0.1 : 0),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                iconTheme:
                    IconThemeData(color: Colors.white, fill: 1, size: 30),
                backgroundColor: Colors.amber,
                pinned: true,
                expandedHeight: 300,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    item["image"],
                    //width: width,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                  child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        child: Row(
                            children: List.generate(
                                    5,
                                    (i) => Icon(Icons.star,
                                        color:
                                            Color.fromARGB(190, 223, 247, 4)))
                                .toList())),
                    Text(
                      item["name"],
                      style: TextStyle(fontSize: 30),
                    ),
                    Text(
                      discription,
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ))
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 250,
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.only(
              right: max((width - 500) / 2, 5),
              left: max((width - 500) / 2, 5),
              top: 5,
              bottom: 5),
          decoration: BoxDecoration(
              color: Color.fromARGB(60, 158, 158, 158),
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: Column(children: [
            Visibility(
              visible: item["halfprice"] != item["price"],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          number = 1;
                          plate = "Full";
                        });
                      },
                      child: Row(
                        children: [
                          Icon(Icons.circle_outlined,
                              color: plate == "Full"
                                  ? Colors.black
                                  : Color.fromARGB(92, 0, 0, 0)),
                          Text("Full plate",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: plate == "Full"
                                      ? Colors.black
                                      : Color.fromARGB(92, 0, 0, 0))),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          number = 1;
                          plate = "Half";
                        });
                      },
                      child: Row(
                        children: [
                          Icon(Icons.circle_outlined,
                              color: plate == "Half"
                                  ? Colors.black
                                  : Color.fromARGB(92, 0, 0, 0)),
                          Text("Half plate",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: plate == "Half"
                                      ? Colors.black
                                      : Color.fromARGB(92, 0, 0, 0))),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: ItemCount(
                        key: Key(plate),
                        initialValue: number,
                        minValue: 1,
                        buttonSizeHeight: 60,
                        buttonSizeWidth: 50,
                        maxValue: max(2, plate == "Full" ? stock / 2 : stock),
                        color: Colors.amber,
                        textStyle: const TextStyle(fontSize: 30),
                        onChanged: (value) {
                          setState(() {
                            number = value;
                          });
                        },
                        decimalPlaces: 0),
                  ),
                  Expanded(
                    child: Container(
                      height: 60,
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Text(
                          "Price:${plate == "Half" ? item["halfprice"] * number : item["price"] * number}₹",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20)),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
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
                        height: 60,
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Text("Add to cart",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          item["count"] = number;
                          item["plate"] = plate;
                        });
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Orderprogress(
                                    [
                                      [item]
                                    ],
                                    plate == "Full"
                                        ? item["price"] * number
                                        : item["halfprice"] * number)));
                      },
                      child: Container(
                        height: 60,
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Text("Buy now",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
