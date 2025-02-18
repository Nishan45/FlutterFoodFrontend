import 'package:flutter/material.dart';
import 'package:frontend/Pages/AboutUs.dart';

class Footer extends StatelessWidget {
  const Footer(this.callback, this.scrolltop, {super.key});
  final Function callback;
  final Function scrolltop;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      color: Color.fromARGB(103, 96, 125, 139),
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              alignment: Alignment.center,
              padding:
                  EdgeInsets.only(left: 150, right: 150, top: 50, bottom: 50),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey))),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Company",
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        InkWell(
                            onTap: () {
                              callback(3);
                              scrolltop();
                            },
                            child: Text("About Us")),
                        InkWell(
                            onTap: () {
                              callback(4);
                              scrolltop();
                            },
                            child: Text("Contact Us")),
                        Text(""),
                        Text("")
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Legal",
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        InkWell(
                            onTap: () {
                              callback(5);
                              scrolltop();
                            },
                            child: Text("Privacy Policy")),
                        InkWell(
                            onTap: () {
                              callback(6);
                              scrolltop();
                            },
                            child: Text("Terms & Condition")),
                        InkWell(
                            onTap: () {
                              callback(7);
                              scrolltop();
                            },
                            child: Text("Refund Policy")),
                        Text(""),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Social Links",
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        Text("Facebook"),
                        Text("Instagram"),
                        Text("Linkdin"),
                        Text("Twitter")
                      ],
                    )
                  ]),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
                "By continuing past this page you agree to our Terms, Cookie policy and Privacy policy. All trademarks are properties of their respective owners. © BECC"),
          )
        ],
      ),
    );
  }
}
