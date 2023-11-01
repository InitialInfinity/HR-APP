import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constant.dart';
import 'splashcontroller.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SplashController splashController = Get.put(SplashController());
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: BLUE,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Image.asset('assets/images/Logo.png', width: 150),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
