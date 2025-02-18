import 'package:flutter/material.dart';
import 'package:flutter_upi_pay/flutter_upi_pay.dart';
import 'package:upi_india/upi_india.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  List<UpiApp> apps = [];
  final UpiIndia _upiIndia = UpiIndia();

  Future<UpiResponse> initiateTransaction(UpiApp app) async {
    return _upiIndia.startTransaction(
        app: app,
        receiverUpiId: "nishan.sarkar00-3@okaxis",
        receiverName: 'NS',
        transactionRefId: 'UpiIndiaPlugin',
        transactionNote: 'Not actual. Just an example.',
        amount: 1,
        flexibleAmount: true);
  }

  @override
  void initState() {
    _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
      setState(() {
        apps = value;
      });
    }).catchError((e) {
      apps = [];
    });
    super.initState();
  }

  FlutterPayment flutterPayment = FlutterPayment();

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          flutterPayment.launchUpi(
              upiId: "nishan.sarkar00-3@okaxis",
              name: "tester",
              amount: "10",
              message: "test",
              currency: "INR");
        },
        child: Text("Pay"));
  }

  TextStyle header = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  TextStyle value = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );

  Widget displayUpiApps() {
    if (apps == null) {
      return Center(child: CircularProgressIndicator());
    } else if (apps!.length == 0) {
      return Center(
        child: Text(
          "No apps found to handle transaction.",
          style: header,
        ),
      );
    } else {
      return Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Wrap(
            children: apps!.map<Widget>((UpiApp app) {
              return GestureDetector(
                onTap: () async {
                  var transaction = await initiateTransaction(app);
                  print(transaction);
                  //setState(() {});
                },
                child: Container(
                  height: 100,
                  width: 100,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.memory(
                        app.icon,
                        height: 60,
                        width: 60,
                      ),
                      Text(app.name),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      );
    }
  }
}
