import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gdsc/resources/authMethod.dart';
import 'package:gdsc/screens/mainScreen.dart';
import 'package:gdsc/screens/registerScreen.dart';
import 'package:gdsc/utils/colors.dart';
import 'package:gdsc/utils/utils.dart';

import '../responsive/mobileScreenLayout.dart';
import '../responsive/responsiveLayoutScreen.dart';
import '../responsive/webScreenlayout.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = "";
  String password = "";
  bool _isLoading = false;

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res =
        await AuthMethods().loginUser(email: email, password: password);

    if (res == "success") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
                webScreenLayout: WebScreenLayout(),
                mobileScreenLayout: MobileScreenLayout())),
      );
    } else {
      showSnackbar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: BackButton(color: Colors.black),
        toolbarHeight: 45,
      ),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 36,
              ),
              const Text(
                "Welcome back!",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 25,
              ),
              const Text(
                "We along with your studymates have missed you!",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff545454)),
              ),
              SizedBox(
                height: 90,
              ),
              Container(
                width: 328,
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "E-mail",
                    labelStyle: TextStyle(
                        color: PrimaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: PrimaryColor, width: 2),
                        borderRadius: BorderRadius.circular(12)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: PrimaryColor, width: 2),
                        borderRadius: BorderRadius.circular(12)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: PrimaryColor, width: 2),
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onChanged: (value) {
                    setState(() {
                      email = value;
                      print(email);
                    });
                  },
                  validator: (value) {
                    return RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value!)
                        ? null
                        : "Please enter a valid email";
                  },
                ),
              ),
              SizedBox(
                height: 31,
              ),
              Container(
                width: 328,
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(
                        color: PrimaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: PrimaryColor, width: 2),
                        borderRadius: BorderRadius.circular(12)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: PrimaryColor, width: 2),
                        borderRadius: BorderRadius.circular(12)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: PrimaryColor, width: 2),
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onChanged: (value) {
                    setState(() {
                      password = value;
                      print(password);
                    });
                  },
                  validator: (val) {
                    if (val!.length < 8) {
                      return "Password must be at least 8 characters";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Forgot password?",
                style: TextStyle(
                    color: Color(0xff83ADFF),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline),
              ),
              SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: loginUser,
                child: _isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: SecondaryColor,
                        ),
                      )
                    : Container(
                        width: 328,
                        height: 44,
                        decoration: BoxDecoration(
                            color: PrimaryColor,
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                          child: Text(
                            "Log in",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
              ),
              SizedBox(
                height: 34,
              ),
              Text.rich(TextSpan(
                  text: "if you do not have an account yet, then ",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                  children: <TextSpan>[
                    TextSpan(
                        text: "sign up here.",
                        style: TextStyle(
                            color: Color(0xff83ADFF),
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterPage()),
                            );
                          })
                  ]))
            ],
          ),
        ),
      )),
    );
  }
}
