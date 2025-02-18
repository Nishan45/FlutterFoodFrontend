import 'dart:math';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/Auth/otp.dart';
import 'package:frontend/fetchdata.dart';
import 'package:url_launcher/url_launcher.dart';

var APPWRITE_ENDPOINT = dotenv.env["APPWRITE_ENDPOINT"].toString();
var APPWRITE_PROJECT = dotenv.env["APPWRITE_PROJECT"].toString();

final account = Account(Client()
    .setEndpoint(APPWRITE_ENDPOINT.toString())
    .setProject(APPWRITE_PROJECT.toString())
    .setSelfSigned(status: true));

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}
// ignore_for_file: prefer_const_constructors

class _RegisterState extends State<Register> {
  var showPassword = false;
  var submitted = false;
  var passwordError = '';
  var nameError = '';
  var phoneError = '';

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String _validatePassword(String password) {
    // Reset error message
    var _errorMessage = '';
    // Password length greater than 8
    if (password.length < 8) {
      _errorMessage += 'Password must be longer than 8 characters.\n';
    }
    // Contains at least one uppercase letter
    if (!password.contains(RegExp(r'[A-Z]'))) {
      _errorMessage += '• Uppercase letter is missing.\n';
    }
    // Contains at least one lowercase letter
    if (!password.contains(RegExp(r'[a-z]'))) {
      _errorMessage += '• Lowercase letter is missing.\n';
    }
    // Contains at least one digit
    if (!password.contains(RegExp(r'[0-9]'))) {
      _errorMessage += '• Digit is missing.\n';
    }
    // Contains at least one special character
    if (!password.contains(RegExp(r'[!@#%^&*(),.?":{}|<>]'))) {
      _errorMessage += '• Special character is missing.\n';
    }
    // If there are no error messages, the password is valid
    return _errorMessage;
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(0.0),
            child: Container(),
          ),
          body: Stack(
            alignment: Alignment.center,
            children: [
              Visibility(
                visible: width > 800,
                child: Image.asset(
                  color: Colors.black.withOpacity(0.5),
                  "images/FoodBackgroundImage.png",
                  width: width,
                  height: height,
                  fit: BoxFit.cover,
                  colorBlendMode: BlendMode.darken,
                ),
              ),
              Visibility(
                visible: width <= 800,
                child: Container(
                  color: Color.fromARGB(156, 7, 255, 164),
                  width: width,
                  height: height,
                  alignment: Alignment.topRight,
                  padding: EdgeInsets.only(top: 10, right: 10),
                  child: Text(
                    "Register",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        decoration: TextDecoration.none),
                  ),
                ),
              ),
              Container(
                // margin: EdgeInsets.only(top: 100),
                padding: EdgeInsets.all(min(500, width) * 0.1),
                width: min(500, width),
                height: width <= 800 ? height : 600,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: width <= 800
                        ? BorderRadius.only(topRight: Radius.circular(width))
                        : BorderRadius.all(Radius.circular(20))),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(bottom: 40),
                        child: Text(
                          "Welcome to BECC",
                          style: TextStyle(fontSize: 30, color: Colors.red),
                        )),
                    TextField(
                      controller: nameController,
                      onChanged: (val) {
                        setState(() {
                          nameError = '';
                        });
                      },
                      decoration: InputDecoration(
                          errorText: !nameError.isEmpty ? nameError : null,
                          hintText: "Name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      onChanged: (val) {
                        setState(() {
                          phoneError = '';
                        });
                      },
                      decoration: InputDecoration(
                          errorText: !phoneError.isEmpty ? phoneError : null,
                          hintText: "Phone",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: passwordController,
                      obscureText: !showPassword,
                      onChanged: (val) {
                        setState(() {
                          passwordError = '';
                        });
                      },
                      decoration: InputDecoration(
                          errorText:
                              !passwordError.isEmpty ? passwordError : null,
                          suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  showPassword = !showPassword;
                                });
                              },
                              child: showPassword
                                  ? Icon(
                                      Icons.visibility,
                                      color: Colors.grey,
                                    )
                                  : Icon(
                                      Icons.visibility_off,
                                      color: Colors.grey,
                                    )),
                          hintText: "Password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RichText(
                        text: TextSpan(
                            text:
                                "By creating an account you are agreeing to our",
                            children: [
                          TextSpan(
                              style: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 68, 33, 243)),
                              text: " Terms & Conditions",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  await launchUrl(Uri.parse(
                                      "https://docs.google.com/document/d/1GAqg2nirmIXBriDM-o4fllJqkeLnWZ7RICB-la4vD4o/edit?tab=t.0"));
                                })
                        ])),
                    SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      height: 40,
                      width: width,
                      child: ElevatedButton(
                        onPressed: () async {
                          var checkpas =
                              _validatePassword(passwordController.text);

                          setState(() {
                            if (!checkpas.isEmpty) {
                              passwordError = checkpas;
                            }
                            if (nameController.text.length < 3) {
                              nameError = "Minimum length is 3";
                            }
                            if (phoneController.text.length < 10) {
                              phoneError = "Minimum length is 10";
                            }
                          });
                          if (passwordError.isEmpty &&
                              phoneError.isEmpty &&
                              nameError.isEmpty) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                });
                            var res =
                                await checkUserExist(phoneController.text);

                            if (res.statusCode == 200) {
                              try {
                                final res = await account.createPhoneToken(
                                    userId: ID.unique(),
                                    phone: '+91${phoneController.text}');
                                if (!res.userId.isEmpty) {
                                  final varified = await Navigator.of(context)
                                      .push(MaterialPageRoute(
                                          builder: (context) =>
                                              OtpVerification(res.userId)));

                                  try {
                                    await account.deleteSessions();
                                  } catch (e) {
                                    //No active session
                                  }
                                  if (varified != null && varified) {
                                    await signUp({
                                      "name": nameController.text,
                                      "username": phoneController.text,
                                      "password": passwordController.text
                                    }).then((res) async {
                                      int code = res.statusCode;
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(code == 200
                                                  ? "Registration successful"
                                                  : "Something went wrong")));
                                      if (code == 200) {
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                      }
                                    });
                                  }
                                }
                                try {
                                  await account.deleteSessions();
                                } catch (e) {
                                  //No active session
                                }
                              } catch (e) {
                                //print(e);
                                print(e);
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(e.toString().contains("limit")
                                        ? "OTP limit exceeded. Try again after sometime"
                                        : "Something went wrong")));
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(res.statusCode == 500
                                          ? "User already exist"
                                          : "Something went wrong")));
                            }
                            Navigator.of(context).pop();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(187, 16, 130, 230)),
                        child: Text(
                          "Register",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Row(children: [
                      Expanded(child: Container()),
                      Text("Already have an account?"),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Login"))
                    ])
                  ],
                ),
              )
            ],
          )),
    );
  }
}
