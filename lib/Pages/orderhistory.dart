import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Admin/order_components/active_orders.dart';
import 'package:frontend/fetchdata.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class UserOrderHistory extends StatefulWidget {
  const UserOrderHistory({super.key});

  @override
  State<UserOrderHistory> createState() => _UserOrderHistoryState();
}

class _UserOrderHistoryState extends State<UserOrderHistory> {
  var data = [];
  var page = 0, limit = 10;
  late ScrollController _scrollController;

  getData() async {
    var res = await getUserOrders(page, limit);
    if (res != null) {
      setState(() {
        data = [...data, ...res];
      });
    }
  }

  _scrollListner() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        page = page + 1;
      });
      getData();
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
    _scrollController = new ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListner);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return data.length > 0
        ? ListView.builder(
            itemCount: data.length,
            controller: _scrollController,
            itemBuilder: (context, index) {
              return orderItems(
                item: data[index],
              );
            })
        : Center(child: Text("Empty"));
  }
}

class orderItems extends StatefulWidget {
  const orderItems({this.item, super.key});
  final item;

  @override
  State<orderItems> createState() => _orderItemsState();
}

class _orderItemsState extends State<orderItems> {
  @override
  Widget build(BuildContext context) {
    var date = widget.item["createdAt"];

    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              "Time: ${DateFormat("dd-MM-yyyy").format(DateTime.parse(date.toString()).toLocal())} at ${DateFormat('hh:mm a').format(DateTime.parse(date.toString()).toLocal())}"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Address: ${widget.item["address"]}"),
                  Text(
                    "Delivery: ${widget.item["deliveryStatus"]}",
                    style: TextStyle(
                        color: widget.item["deliveryStatus"] == "successful"
                            ? Colors.green
                            : Colors.blue),
                  ),
                  Text(
                    "Payment: ${widget.item["paymentStatus"]}",
                    style: TextStyle(
                        color: widget.item["paymentStatus"] == "successful"
                            ? Colors.green
                            : Colors.blue),
                  )
                ],
              ),
              Column(
                children: [
                  Text("${widget.item["totalPrice"]}₹"),
                  Text("Pin: ${widget.item["pin"]}"),
                  TextButton(
                      onPressed: () async {
                        await showDialog(
                            context: context,
                            builder: (context) {
                              return StatefulBuilder(
                                  builder: (context, setState) {
                                return AlertDialog(
                                  scrollable: true,
                                  backgroundColor: Colors.white,
                                  title: const Text("Order Summary"),
                                  content: Column(
                                    children: (widget.item["items"] as List)
                                        .asMap()
                                        .entries
                                        .map((val) {
                                      return HistoryItem(
                                          item: val.value, index: val.key);
                                    }).toList(),
                                  ),
                                );
                              });
                            });
                        //Navigator.of(context).pop();
                      },
                      child: Text("View items")),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

class HistoryItem extends StatefulWidget {
  const HistoryItem({super.key, this.item, this.index});
  final item;
  final index;

  @override
  State<HistoryItem> createState() => _HistoryItemState();
}

class _HistoryItemState extends State<HistoryItem> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var item = widget.item;

    return Container(
        width: width,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(color: Colors.grey, offset: Offset(0.0, 1.0), blurRadius: 1)
        ]),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Column(children: [
                item["image"] != null
                    ? Image.network(
                        item["image"],
                        fit: BoxFit.cover,
                        height: 60,
                        width: 60,
                      )
                    : Container(
                        width: 60,
                        height: 60,
                        color: Colors.grey,
                      ),
                Container(
                  width: 60,
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
                    SelectableText(
                      "Item : ${widget.index + 1}",
                    ),
                    Text(
                      "Price:${item["price"]}₹",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      "Plate number:${item["quantity"]}",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      "Plate type:${item["platetype"]}",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
