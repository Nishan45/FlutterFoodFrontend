import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:scroll_loop_auto_scroll/scroll_loop_auto_scroll.dart';
import '../fetchdata.dart';

var server_url = dotenv.env["SERVER_URL"];
var url_getadvertisement = "${server_url}/GetAdvertisement";

class Imageslider extends StatefulWidget {
  const Imageslider({super.key});

  @override
  State<Imageslider> createState() => _ImagesliderState();
}

class _ImagesliderState extends State<Imageslider> {
  /*var data = [
    {"id": 1, "image": "assets/images/food1.webp"},
    {"id": 2, "image": "assets/images/food2.webp"},
    {"id": 3, "image": "assets/images/food3.jpeg"},
    {"id": 4, "image": "assets/images/food4.jpeg"},
    {"id": 5, "image": "assets/images/food1.webp"},
    {"id": 6, "image": "assets/images/food2.webp"},
    {"id": 7, "image": "assets/images/food3.jpeg"},
    {"id": 8, "image": "assets/images/food4.jpeg"}
  ];*/
  List data = [];

  int currentIndex = 0;
  onpagechange(index) {
    setState(() {
      currentIndex = index;
    });
  }

  getAdvertisement() async {
    var new_data = await getAdvertisementData(url_getadvertisement);
    setState(() {
      data = new_data as List;
    });
  }

  @override
  void initState() {
    super.initState();
    getAdvertisement();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
        child: Column(children: [
      Container(
        padding: EdgeInsets.only(top: 10),
        color: Colors.white,
        /*child: width >= 700
            ? WebSlide(data, onpagechange)
            : AndroidSlide(data, onpagechange),*/
        child: AndroidSlide(data, onpagechange),
      ),
      Visibility(
        visible: width < 700 ? true : false,
        child: Container(
            color: Colors.white,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: data
                    .asMap()
                    .entries
                    .map((e) => Container(
                        margin: const EdgeInsets.all(2),
                        child: Icon(Icons.circle,
                            size: 5,
                            color: currentIndex == e.key
                                ? Colors.blue
                                : Colors.black)))
                    .toList())),
      )
    ]));
  }
}

class AndroidSlide extends StatefulWidget {
  const AndroidSlide(this.data, this.onpagechange, {super.key});
  final data;
  final onpagechange;

  @override
  State<AndroidSlide> createState() => _AndroidSlideState();
}

class _AndroidSlideState extends State<AndroidSlide> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    List data = widget.data as List;
    return CarouselSlider(
        items: data.map((item) {
          return Container(
              padding: width > 800
                  ? const EdgeInsets.all(10)
                  : const EdgeInsets.all(5),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    item["image"],
                    fit: BoxFit.fill,
                    width: width,
                  )));
        }).toList(),
        options: CarouselOptions(
          onPageChanged: (index, reason) {
            widget.onpagechange(index);
          },
          aspectRatio: 3 / 2,
          height: min(width * 0.4, 200),
          viewportFraction: width > 1200
              ? 0.2
              : width > 800
                  ? 0.34
                  : 0.6,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          enlargeFactor: 0.2,
          scrollDirection: Axis.horizontal,
        ));
  }
}

class WebSlide extends StatefulWidget {
  const WebSlide(this.data, this.onpagechange, {super.key});
  final data;
  final onpagechange;

  @override
  State<WebSlide> createState() => _WebSlideState();
}

class _WebSlideState extends State<WebSlide> {
  ScrollController _scrollController = ScrollController();
  late double direction;

  /*@override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      double max = _scrollController.position.maxScrollExtent;
      double min = _scrollController.position.minScrollExtent;
      setState(() {
        direction = max;
      });
      animateTo(max, min, 10, _scrollController);
    });

    /*Future.delayed(const Duration(microseconds: 10), () {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('0');
        _scrollController.animateTo(_scrollController.position.minScrollExtent,
            duration: Duration(seconds: 10), curve: Curves.linear);
      } else {
        print(0);
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: Duration(seconds: 10), curve: Curves.linear);
      }
    });*/
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() {
          direction = _scrollController.position.maxScrollExtent;
        });
      } else {
        setState(() {
          direction = _scrollController.position.minScrollExtent;
        });
      }
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
            
        _scrollController.jumpTo(_scrollController.position.minScrollExtent);
      }
    });
  }

  animateTo(
      double max, double min, int time, ScrollController scrollController) {
    scrollController
        .animateTo(direction,
            duration: Duration(seconds: time), curve: Curves.linear)
        .then((value) {
      // direction = direction == max ? min : max;
      animateTo(max, min, time, scrollController);
    });
  }*/

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    List data = widget.data as List;
    //var data = widget.data;
    return Container(
      alignment: Alignment.center,
      height: height * 0.3,
      child: ScrollLoopAutoScroll(
        scrollDirection: Axis.horizontal,
        delay: Duration(seconds: 1),
        duration: Duration(seconds: 500),
        //gap: 25,
        //reverseScroll: true,
        //duplicateChild: 25,
        enableScrollInput: true,
        delayAfterScrollInput: Duration(microseconds: 500),
        child: Row(
          children: data.map((item) {
            return Container(
                width: width < 1000 ? width * 0.3 : width * 0.25,
                height: height * 0.3,
                padding: EdgeInsets.all(width * 0.01),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      item["image"],
                      fit: BoxFit.cover,
                    )));
          }).toList(),
        ),
      ),
    );
  }
}

/*        child: ListView.builder(
            itemCount: data.length,
            scrollDirection: Axis.horizontal,
            controller: _scrollController,
            itemBuilder: (context, index) {
              return Container(
                  width: width * 0.25,
                  padding: EdgeInsets.all(width * 0.01),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        data[index]["image"],
                        fit: BoxFit.cover,
                      )));
            }),
  */
