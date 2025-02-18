import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/components/itemdetail.dart';
import 'package:frontend/fetchdata.dart';

class Debouncer {
  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;
  Debouncer({required this.milliseconds});
  run(VoidCallback action) {
    if (_timer != null) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class Searchpage extends StatefulWidget {
  const Searchpage({super.key});

  @override
  State<Searchpage> createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  final _debouncer = Debouncer(milliseconds: 500);
  var searchFilter = [];
  var key = 0;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                    width: width * 0.1,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.arrow_back,
                      ),
                    )),
                Container(
                  width: width * 0.8,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: Material(

                      //elevation: 1,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      child: TextField(
                        onChanged: (value) {
                          _debouncer.run(() async {
                            var time = DateTime.now().toUtc().toIso8601String();
                            var res = await searchMenuItems(
                                time, 0, 10, {"name": value});
                            setState(() {
                              searchFilter = res;
                              key ^= 1;
                            });
                          });
                        },
                        autofocus: true,
                        decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.search),
                            contentPadding: EdgeInsets.all(10),
                            hintText: "Search",
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none),
                      )),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                key: Key(key.toString()),
                children: searchFilter.map((item) {
                  return Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: width * 0.1 + 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Itemdetail(item)));
                      },
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(width * 0.03)),
                            child: Image.network(
                                fit: BoxFit.cover,
                                width: width * 0.12,
                                height: width * 0.12,
                                item["image"]),
                          ),
                          Padding(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item["name"]),
                                    Text(item["category"],
                                        style: TextStyle(color: Colors.grey))
                                  ])),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
