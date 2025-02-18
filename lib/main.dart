import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:frontend/Admin/admin_menu.dart';
import 'package:frontend/Admin/admin_order.dart';
import 'package:frontend/Admin/order_components/active_orders.dart';
import 'package:frontend/Admin/order_components/order_history.dart';
import 'package:frontend/Auth/app.dart';
import 'package:frontend/Auth/homepage.dart';
import 'package:frontend/Auth/login.dart';
import 'package:frontend/Auth/otp.dart';
import 'package:frontend/Auth/recoverpassword.dart';
import 'package:frontend/Auth/register.dart';
import 'package:frontend/Pages/AboutUs.dart';
import 'package:frontend/Pages/Privacy.dart';
import 'package:frontend/Pages/Terms.dart';
import 'package:frontend/Pages/cart.dart';
import 'package:frontend/Pages/contactus.dart';
import 'package:frontend/Pages/orderhistory.dart';
import 'package:frontend/Pages/orderprogress.dart';
import 'package:frontend/components/filter.dart';
import 'package:frontend/fetchdata.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore_for_file: prefer_const_constructors

class MyService {
  /*MyService._oneTime();

  static final _instance = MyService._oneTime();

  factory MyService() {
    return _instance;
  }*/

  Future<bool> asyncInit() async {
    var user = await getUserData();
    if (user != null) {
      var res = await Authentication(user[1]);
      if (res.statusCode == 200) {
        return true;
      }
    }
    return false;
  }
}

void main() async {
  await dotenv.load(fileName: "assets/.env");

  //Stripe.publishableKey = dotenv.env["STRIPE_PUBLISHABLE_KEY"] as String;

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //statusBarColor: Color.fromARGB(156, 7, 255, 164),
    statusBarColor: Colors.transparent,
  ));
  //SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  /*await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDKaN2OjtHsjyscLgTXjpSN2oBQgdreE9k",
      appId: "1:866320770453:android:2f1262b7673c196a7ac29c",
      messagingSenderId: "866320770453",
      projectId: "flutter-food-delivery-ap-5903b",
    ),
  );
  await FirebaseMessaging.instance.getToken().then(
    (value) {
      print(value);
    },
  );*/

  runApp(FutureBuilder(
    future: MyService().asyncInit(),
    builder: (_, snap) {
      if (snap.connectionState == ConnectionState.done && snap.data != null) {
        var check = false;

        if (snap.data != null) {
          check = snap.data as bool;
        }

        return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: check ? "app" : "login",
            //initialRoute: "app",
            theme: ThemeData(scaffoldBackgroundColor: Colors.white),
            routes: {
              "login": (context) => Login(),
              "register": (context) => Register(),
              "homepage": (context) => Homepage(),
              "app": (context) => App(),
              "ex": (context) => ContactUs(),
            });
      }
      return Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ));
    },
  ));
}
