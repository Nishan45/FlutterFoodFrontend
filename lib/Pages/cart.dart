import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/Admin/order_components/order_history.dart';
import 'package:frontend/Pages/orderhistory.dart';
import 'package:frontend/Pages/orderprogress.dart';
import 'package:frontend/fetchdata.dart';
import 'package:frontend/global_variables.dart';
import 'package:item_count_number_button/item_count_number_button.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  List data = [];

  getCartitems() async {
    var new_data = await getCartData();
    setState(() {
      data = new_data as List;
    });
  }

  @override
  void initState() {
    super.initState();
    getCartitems();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 20,
              backgroundColor: Colors.white,
              bottom: PreferredSize(
                preferredSize: Size(width, 20),
                child: TabBar(
                    labelPadding: EdgeInsets.all(5),
                    tabs: [Text("Order"), Text("History")]),
              ),
            ),
            body: TabBarView(children: [
              !data.isEmpty
                  ? Mycart(data, "Order")
                  : Center(child: Text("Empty")),
              UserOrderHistory()
            ]),
          )),
    );
  }
}

class Mycart extends StatefulWidget {
  const Mycart(this.items, this.tag, {super.key});
  final items;
  final tag;
  @override
  State<Mycart> createState() => _MycartState();
}

class _MycartState extends State<Mycart> {
  num total_price = 0;
  var item;
  var key = 0;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.items.length; i++) {
      total_price += widget.items[i][0]["price"];
    }
    setState(() {
      item = widget.items;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    void change_price(num prv, num cur, num index, num number) {
      setState(() {
        total_price -= prv;
        total_price += cur;
        item[index][0]["count"] = number;
      });
    }

    void change_price_on_delete(num price) {
      setState(() {
        total_price -= price;
      });
    }

    void change_plate(num index, String plate) {
      setState(() {
        item[index][0]["plate"] = plate;
      });
    }

    void delete_item(int index) {
      setState(() {
        key ^= 1;
        item.removeAt(index);
      });
    }

    return Scaffold(
      bottomNavigationBar: widget.tag == "Order"
          ? Container(
              height: 60,
              padding: EdgeInsets.all(10),
              color: const Color.fromARGB(87, 158, 158, 158),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Price: ${total_price}₹"),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                Orderprogress(item, total_price)));
                      },
                      child: Container(
                          margin: EdgeInsets.only(left: 20),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Text(
                            "Place order",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  )
                ],
              ),
            )
          : null,
      body: ListView.builder(
          key: Key(key.toString()),
          itemCount: item.length,
          itemBuilder: (context, index) {
            return CartItem(item[index], index, change_price, change_plate,
                delete_item, change_price_on_delete);
          }),
    );
  }
}

class CartItem extends StatefulWidget {
  const CartItem(this.item, this.index, this.callback, this.changePlate,
      this.deleteItem, this.changePriceOnDelete,
      {super.key});
  final item;
  final index;
  final Function callback;
  final Function changePlate;
  final Function deleteItem;
  final Function changePriceOnDelete;

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem>
    with AutomaticKeepAliveClientMixin {
  num number = 1;
  var plate = "Full";
  var userId = "userId";

  @override
  Widget build(BuildContext context) {
    var item = widget.item[0];
    var callback = widget.callback;
    var changePlate = widget.changePlate;

    var price = 399;
    var stock = item["stock"];
    var width = MediaQuery.of(context).size.width;
    var index = widget.index;

    return Container(
        width: width,
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(color: Colors.grey, offset: Offset(0.0, 1.0), blurRadius: 1)
        ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(children: [
              Image.network(
                item["image"],
                fit: BoxFit.cover,
                height: 70,
                width: 70,
              ),
              Container(
                width: 70,
                alignment: Alignment.center,
                child: Text(
                  item["name"],
                  style: const TextStyle(overflow: TextOverflow.ellipsis),
                ),
              ),
            ]),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ItemCount(
                          key: Key(plate),
                          initialValue: number,
                          minValue: 1,
                          maxValue: max(2, plate == "Full" ? stock / 2 : stock),
                          color: Colors.amber,
                          textStyle: const TextStyle(fontSize: 30),
                          onChanged: (value) {
                            num prv = number;
                            setState(() {
                              number = value;
                            });

                            callback(prv * item["price"], value * item["price"],
                                index, number);
                          },
                          decimalPlaces: 0),
                      Text(
                          " | ${plate == "Full" ? item["price"] * number : item["halfprice"] * number}₹"),
                    ],
                  ),
                  Visibility(
                    visible: item["halfprice"] != item["price"],
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                plate = "Full";
                                number = 1;
                                changePlate(index, plate);
                              });
                            },
                            child: Row(
                              children: [
                                Icon(Icons.circle_outlined,
                                    color: plate == "Full"
                                        ? Colors.black
                                        : Color.fromARGB(92, 0, 0, 0)),
                                Text("Full plate",
                                    softWrap: true,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                        //fontSize: 20,
                                        color: plate == "Full"
                                            ? Colors.black
                                            : Color.fromARGB(92, 0, 0, 0))),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20, left: 10),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                plate = "Half";
                                number = 1;
                                changePlate(index, plate);
                              });
                            },
                            child: Row(
                              children: [
                                Icon(Icons.circle_outlined,
                                    color: plate == "Half"
                                        ? Colors.black
                                        : Color.fromARGB(92, 0, 0, 0)),
                                Text("Half plate",
                                    overflow: TextOverflow.fade,
                                    softWrap: true,
                                    style: TextStyle(
                                        //fontSize: 20,
                                        color: plate == "Half"
                                            ? Colors.black
                                            : Color.fromARGB(92, 0, 0, 0))),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(right: 10),
                          child: TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Orderprogress([
                                          [item]
                                        ], item["price"] * item["count"])));
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all<Color>(
                                          Colors.green)),
                              child: Text("Order now",
                                  style: TextStyle(color: Colors.white))),
                        ),
                        Container(
                          child: TextButton(
                              onPressed: () async {
                                var res = await deleteCart(userId, item["_id"]);
                                if (res.statusCode == 200) {
                                  widget.deleteItem(index);
                                  widget.changePriceOnDelete(
                                      number * item["price"]);
                                }
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all<Color>(
                                          Color.fromARGB(255, 201, 204, 204))),
                              child: Text("Remove",
                                  style: TextStyle(color: Colors.white))),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
