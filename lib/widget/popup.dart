import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../constant.dart';
import '../service.dart';

Future<void> showMyDialog(var data, String title1, String title2,
    String btntext, Function onPressed) async {
  return showDialog<void>(
    context: Get.context!,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: normaltext("$title2 ", RED),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              RichText(
                text: TextSpan(
                  text: title1,
                  style: TextStyle(color: BLACK),
                  children: <TextSpan>[
                    TextSpan(
                        text: title2,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: BLACK,
                        )),
                    TextSpan(text: '?'),
                  ],
                ),
              )
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: normaltext(
              'Cancel',
              RED,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          TextButton(
            child: normaltext(
              btntext,
              RED,
            ),
            onPressed: () {
              onPressed.call();
              Get.back();
            },
          ),
        ],
      );
    },
  );
}

Future<bool> onWillPopHome({bool? canBackClose}) async {
  bool? exitResult = await Get.dialog(
    WillPopScope(
      onWillPop: () async {
        if (canBackClose == null) {
          return false;
        }
        return true;
      },
      child: AlertDialog(
        title: const Text('Please Confirm'),
        content: const Text('Do you want to exit the app?'),
        actions: <Widget>[
          TextButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
            onPressed: () => Get.back(canPop: false),
            child: const Text(
              'No',
              style: TextStyle(color: BLUE),
            ),
          ),
          TextButton(
            style:
                ButtonStyle(backgroundColor: MaterialStateProperty.all(BLUE)),
            onPressed: () => Service.logout(),
            child: const Text(
              'Yes',
              style: TextStyle(color: WHITE),
            ),
          ),
        ],
      ),
    ),
  );
  return exitResult ?? false;
}
