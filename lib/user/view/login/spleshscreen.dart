import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_firebase/utils/fb_helper.dart';

class SpleshScreen extends StatefulWidget {
  const SpleshScreen({Key? key}) : super(key: key);

  @override
  State<SpleshScreen> createState() => _SpleshScreenState();
}

class _SpleshScreenState extends State<SpleshScreen> {
  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(seconds: 3),
      () {
        FireBaseHelper.fireBaseHelper.Checklogin() == true
            ? Get.offAndToNamed("/home")
            : Get.offAndToNamed('/welcome');
      },
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            child: Image.asset(
              "assets/images/splesh.png",
            ),
          ),
        ),
      ),
    );
  }
}
