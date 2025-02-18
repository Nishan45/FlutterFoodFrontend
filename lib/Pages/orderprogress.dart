import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/components/payment.dart';
import 'package:frontend/fetchdata.dart';
import 'package:frontend/global_variables.dart';

/*var data = [
  {"id": 1, "image": "assets/images/food1.webp", "name": "Pizza", "price": 199},
  {"id": 2, "image": "assets/images/food2.webp", "name": "Pizza", "price": 199},
  {"id": 3, "image": "assets/images/food3.jpeg", "name": "Pizza", "price": 199},
  {"id": 4, "image": "assets/images/food4.jpeg", "name": "Pizza", "price": 199},
  {"id": 5, "image": "assets/images/food1.webp", "name": "Pizza", "price": 199},
  {"id": 6, "image": "assets/images/food2.webp", "name": "Pizza", "price": 199},
  {"id": 7, "image": "assets/images/food3.jpeg", "name": "Pizza", "price": 199},
  {"id": 8, "image": "assets/images/food4.jpeg", "name": "Pizza", "price": 199}
];*/

var adresses = [
  "1st Gate",
  "2nd Gate",
  "Library",
  "1st Gate",
  "2nd Gate",
  "Library",
  "Old Building 1st Lobby",
  "Old Building 2nd Lobby",
  "New Building",
  "A.C. Roy Hall (H-7)",
  "Hostel-11",
  "Hostel-14",
  "Hostel-15",
  "Hostel-16",
  "Hostel-PG (H-13)",
  "Lt Williams MacDonald Hall",
  "MacDonald Hall",
  "Pandya Hall",
  "H-15 Exten Qtr-D",
  "Richardson Hall",
  "Sen Hall",
  "Sen Hall Sengupta Hall Qtrs Sengupta Hall Wolfenden Hall"
];

class Orderprogress extends StatefulWidget {
  const Orderprogress(this.data, this.totalPrice, {super.key});
  final data;
  final totalPrice;

  @override
  State<Orderprogress> createState() => _OrderprogressState();
}

class _OrderprogressState extends State<Orderprogress> {
  var currentstep = 0;
  var currentPaymentMode = 0;
  var confirm = false;
  var address = adresses[0].toString();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var data = widget.data;
    var totalPrice = widget.totalPrice;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Theme(
          data: ThemeData(canvasColor: Colors.white),
          child: Stepper(
              elevation: 0,
              currentStep: currentstep,
              onStepTapped: (value) {
                if (currentstep > value) {
                  setState(() {
                    currentstep = value;
                  });
                }
              },
              onStepCancel: () {
                Navigator.of(context).pop();
              },
              onStepContinue: () async {
                if (currentstep == 2) {
                  await showDialog(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(builder: (context, setState) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            title: const Text("Confirmation"),
                            content: const Text("Are you sure"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      confirm = true;
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Yes")),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("No")),
                            ],
                          );
                        });
                      });
                  if (confirm) {
                    var res = await makeOrder(
                        data, totalPrice, address, "pending", "offline");

                    await showDialog(
                      context: context,
                      builder: (context) {
                        Future.delayed(const Duration(seconds: 1), () {
                          Navigator.of(context).pop();
                        });

                        return AlertDialog(
                          backgroundColor: Colors.white,
                          content: Container(
                            width: width * 0.8,
                            height: width * 0.8,
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Icon(
                                  size: width * 0.5,
                                  res.statusCode == 200
                                      ? Icons.check_circle_outline
                                      : Icons.cancel_outlined,
                                  color: res.statusCode == 200
                                      ? Colors.green
                                      : Colors.red,
                                ),
                                FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text(
                                    res.statusCode == 200
                                        ? "Thank You"
                                        : "Sorry",
                                    style: TextStyle(
                                        color: res.statusCode == 200
                                            ? Colors.green
                                            : Colors.red,
                                        fontSize: 50),
                                  ),
                                ),
                                FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text(
                                    res.statusCode == 200
                                        ? "Your order has been placed"
                                        : "Something went wrong",
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                    Navigator.of(context).pop();
                  }
                } else {
                  setState(() {
                    currentstep += 1;
                    if (currentstep >= 3) {
                      currentstep = 0;
                    }
                  });
                }
              },
              type: StepperType.horizontal,
              steps: [
                Step(
                    label:
                        const Text("Summary", style: TextStyle(fontSize: 12)),
                    stepStyle: StepStyle(
                        color: Colors.blue,
                        connectorColor: currentstep > 0 ? Colors.blue : null),
                    title: const Text(""),
                    content: Container(
                        height: height * 0.7,
                        child: OrderSummary(
                          data: data,
                          total_price: totalPrice,
                        ))),
                Step(
                    label:
                        const Text("Address", style: TextStyle(fontSize: 12)),
                    stepStyle: StepStyle(
                      connectorColor: currentstep > 1 ? Colors.blue : null,
                      color: currentstep > 0 ? Colors.blue : null,
                    ),
                    title: const Text(""),
                    content: Container(
                        //color: Colors.green,
                        height: height * 0.7,
                        alignment: Alignment.topCenter,
                        child: DropdownMenu(
                            initialSelection: adresses[0],
                            onSelected: (value) {
                              setState(() {
                                address = value.toString();
                              });
                            },
                            menuStyle: MenuStyle(
                                backgroundColor: WidgetStateProperty.all<Color>(
                                    Colors.white)),
                            width: width * 0.8,
                            //enableSearch: true,
                            //enableFilter: true,
                            hintText: "Address",
                            dropdownMenuEntries: adresses.map((adress) {
                              return DropdownMenuEntry(
                                  value: adress, label: adress);
                            }).toList()))),
                Step(
                    label:
                        const Text("Payment", style: TextStyle(fontSize: 12)),
                    stepStyle: StepStyle(
                      color: currentstep > 1 ? Colors.blue : null,
                    ),
                    title: const Text(""),
                    content: Container(
                      height: height * 0.7,
                      width: width,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                currentPaymentMode = 0;
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(10),
                              width: width,
                              color: currentPaymentMode == 0
                                  ? Color.fromARGB(255, 227, 241, 248)
                                  : Color.fromARGB(255, 227, 231, 234),
                              child: Text("Offline",
                                  style: TextStyle(fontSize: 15)),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                currentPaymentMode = 1;
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.all(10),
                              width: width,
                              padding: EdgeInsets.all(10),
                              color: currentPaymentMode == 1
                                  ? Color.fromARGB(255, 227, 241, 248)
                                  : Color.fromARGB(255, 227, 231, 234),
                              child: Text("Online",
                                  style: TextStyle(fontSize: 15)),
                            ),
                          )
                        ],
                      ),
                    ))
              ]),
        ),
      ),
    );
  }
}

class OrderSummary extends StatelessWidget {
  const OrderSummary({super.key, this.data, this.total_price});
  final data;
  final total_price;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          forceMaterialTransparency: true,
          backgroundColor: Colors.white,
          title: Center(
              child: Text(
            "Total Price $total_price₹",
            style: TextStyle(fontSize: 15),
          ))),
      body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return SummaryItem(item: data[index][0]);
          }),
    );
  }
}

class SummaryItem extends StatelessWidget {
  const SummaryItem({super.key, this.item});
  final item;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Container(
        width: width,
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(color: Colors.grey, offset: Offset(0.0, 1.0), blurRadius: 1)
        ]),
        child: Row(
          children: [
            Column(children: [
              Image.network(
                item["image"],
                fit: BoxFit.cover,
                height: 100,
                width: 100,
              ),
            ]),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: width - 20 * 2 - 10 * 2 - 20 - 100 - 60,
                    child: Text(
                      item["name"],
                      style: const TextStyle(
                          fontSize: 20, overflow: TextOverflow.ellipsis),
                    ),
                  ),
                  Text(
                    "Price:${item["plate"] == "Full" ? item["price"] : item["halfprice"]}₹",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    "Plate number:${item["count"]}",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    "Plate type:${item["plate"]}",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
