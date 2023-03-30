import 'dart:typed_data';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gdsc/resources/authMethod.dart';
import 'package:gdsc/responsive/mobileScreenLayout.dart';
import 'package:gdsc/responsive/responsiveLayoutScreen.dart';
import 'package:gdsc/responsive/webScreenlayout.dart';
import 'package:gdsc/screens/loginScreen.dart';
import 'package:gdsc/utils/colors.dart';
import 'package:gdsc/utils/utils.dart';
import 'package:gdsc/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'registerScreen.dart';

class RegisterBio extends StatefulWidget {
  final String email;
  final String password;
  const RegisterBio({super.key, required this.email, required this.password});

  @override
  State<RegisterBio> createState() => _RegisterBioState();
}

class _RegisterBioState extends State<RegisterBio> {
  String name = "";
  String bday = "";
  String univ = "";
  String program = "";
  String bio = "";
  Uint8List? _image;
  bool _isLoading = false;

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
        email: widget.email,
        password: widget.password,
        name: name,
        bday: bday,
        univ: univ,
        program: program,
        bio: bio,
        file: _image!);
    setState(() {
      _isLoading = false;
    });
    if (res != 'success') {
      showSnackbar(res, context);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            webScreenLayout: WebScreenLayout(),
            mobileScreenLayout: MobileScreenLayout(),
          ),
        ),
      );
    }
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
        padding: EdgeInsets.symmetric(horizontal: 25),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 36),
                child: Text(
                  "Let us know more about you!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                height: 26,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Text(
                  "Not only for us though, your future study partners need to know you more.",
                  style: TextStyle(
                      color: Color(0xff545454),
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: 84,
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
                    labelText: "Name",
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
                      name = value;
                      print(name);
                    });
                  },
                ),
              ),
              SizedBox(
                height: 21,
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
                    labelText: "Birth date",
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
                      bday = value;
                      print(bday);
                    });
                  },
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 175),
                child: Text(
                  "Example: 1 January 2023",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: 21,
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
                    labelText: "University",
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
                      univ = value;
                      print(univ);
                    });
                  },
                ),
              ),
              SizedBox(
                height: 21,
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
                    labelText: "Program",
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
                      program = value;
                      print(program);
                    });
                  },
                ),
              ),
              SizedBox(
                height: 21,
              ),
              Container(
                width: 328,
                height: 61,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Bio",
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
                      bio = value;
                      print(bio);
                    });
                  },
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 175),
                child: Text(
                  "Maximum words are 150",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 2500,
                height: 250,
                child: _image != null
                    ? DecoratedBox(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: MemoryImage(_image!),
                              fit: BoxFit.cover,
                            )),
                        child: IconButton(
                          onPressed: selectImage,
                          icon: Icon(Icons.add_a_photo),
                        ),
                      )
                    : DecoratedBox(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: NetworkImage(
                                  'https://winaero.com/blog/wp-content/uploads/2018/08/Windows-10-user-icon-big.png'),
                              fit: BoxFit.cover,
                            )),
                        child: IconButton(
                          onPressed: selectImage,
                          icon: Icon(Icons.add_a_photo),
                        ),
                      ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: signUpUser,
                child: _isLoading
                    ? const Center(
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
                            "Continue",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
              ),
              SizedBox(
                height: 25,
              )
            ],
          ),
        ),
      )),
    );
  }
}
